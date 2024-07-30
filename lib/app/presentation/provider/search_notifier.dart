import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/app/domain/repositories/product_repository.dart';
import 'package:autotureid/core/utils/notifier_state.dart';
import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  final ProductRepository productRepository;

  SearchNotifier({required this.productRepository});

  NotifierState<List<Product>> searchProductsState = NotifierState();

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool searchMode = false;

  void onSearchModeOn() {
    searchMode = true;
    searchFocusNode.requestFocus();
    notifyListeners();
  }

  void onSearchModeOff() {
    searchMode = false;
    searchController.clear();
    searchFocusNode.unfocus();
    searchProductsState.reset();
    notifyListeners();
  }

  void onSearchModeToggle() {
    searchMode = !searchMode;
    if (searchMode) {
      searchFocusNode.requestFocus();
    } else {
      searchController.clear();
      searchFocusNode.unfocus();
    }
    notifyListeners();
  }

  void onSearchChanged(String value) async {
    if (value.isEmpty) {
      searchProductsState.reset();
      notifyListeners();
      return;
    }
    searchProductsState.setLoading();
    notifyListeners();

    final result = await productRepository.searchProducts(value);

    result.fold(
      (failure) {
        searchProductsState.setError(error: failure.message);
      },
      (products) {
        searchProductsState.setSuccess(value: products);
      },
    );
    notifyListeners();
  }
}
