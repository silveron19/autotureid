import 'dart:async';

import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/app/domain/repositories/product_repository.dart';
import 'package:autotureid/core/failure.dart';
import 'package:autotureid/core/utils/notifier_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  final ProductRepository productRepository;

  ProductNotifier({required this.productRepository});

  NotifierState<void> getHomeProductsState = NotifierState();
  NotifierState<List<Product>> allProductsState = NotifierState();
  NotifierState<void> fetchMoreProductsState = NotifierState();
  NotifierState<List<Product>> newProductsState = NotifierState();
  NotifierState<List<Product>> lastSeenProductsState = NotifierState();
  NotifierState<Product> productDetailState = NotifierState();

  StreamSubscription<Either<Failure, Product>>? _productDetailSubscription;

  Future<void> getAllProducts() async {
    allProductsState.setLoading();
    notifyListeners();

    final result = await productRepository.getAllProducts(null);

    result.fold(
      (failure) {
        allProductsState.setError(error: failure.message);
        notifyListeners();
      },
      (products) {
        allProductsState.setSuccess(value: products);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> fetchMoreProducts(Product lastProduct) async {
    fetchMoreProductsState.setLoading();
    notifyListeners();

    final result = await productRepository.getAllProducts(lastProduct);

    result.fold(
      (failure) {
        fetchMoreProductsState.setError(error: failure.message);
      },
      (products) {
        fetchMoreProductsState.setSuccess();
        allProductsState.value!.addAll(products);
      },
    );
    notifyListeners();
  }

  Future<void> getNewProducts() async {
    newProductsState.setLoading();
    notifyListeners();

    final result = await productRepository.getNewProducts();

    result.fold(
      (failure) {
        newProductsState.setError(error: failure.message);
        notifyListeners();
      },
      (products) {
        newProductsState.setSuccess(value: products);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getLastSeenProducts() async {
    lastSeenProductsState.setLoading();
    notifyListeners();

    final result = await productRepository.getLastSeenProducts();

    result.fold(
      (failure) {
        lastSeenProductsState.setError(error: failure.message);
        notifyListeners();
      },
      (products) {
        lastSeenProductsState.setSuccess(value: products);
        notifyListeners();
      },
    );
    notifyListeners();
  }

  void getHomeProducts() async {
    getHomeProductsState.setLoading();
    notifyListeners();

    await getNewProducts();
    await getLastSeenProducts();

    if (newProductsState.isSuccess() && lastSeenProductsState.isSuccess()) {
      getHomeProductsState.setSuccess();
    } else if (newProductsState.isError() || lastSeenProductsState.isError()) {
      getHomeProductsState.setError(
          error: newProductsState.failure ?? lastSeenProductsState.failure);
    }
    notifyListeners();
  }

  void getProductDetail(String productId) {
    productDetailState.setLoading();
    notifyListeners();

    bool firstTime = true;

    _productDetailSubscription?.cancel();
    _productDetailSubscription = productRepository.getProductDetail(productId).listen(
      (event) {
        event.fold(
          (failure) {
            productDetailState.setError(error: failure.message);
          },
          (product) async {
            productDetailState.setSuccess(value: product);
            if (firstTime) {
              firstTime = false;
              // add product id to last seen in firestore
              final result = await productRepository.addProductToLastSeen(productId);
              result.fold(
                (failure) {
                  productDetailState.setError(error: failure.message);
                },
                (value) async {
                  productDetailState.setSuccess(value: product);
                  await getLastSeenProducts();
                },
              );
            }
          },
        );
        notifyListeners();
      },
      onError: (error) {
        productDetailState.setError(error: error.toString());
        notifyListeners();
      },
    );
  }

  void cancelProductDetailSubscription() {
    _productDetailSubscription?.cancel();
  }
}
