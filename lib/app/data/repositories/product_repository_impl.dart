import 'dart:io';

import 'package:autotureid/app/data/datasources/abstracts/product/product_remote_data_source.dart';
import 'package:autotureid/app/data/models/product_model.dart';
import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/app/domain/repositories/product_repository.dart';
import 'package:autotureid/core/custom_exception.dart';
import 'package:autotureid/core/failure.dart';
import 'package:autotureid/core/parameter/product_parameter.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getLastSeenProducts() async {
    try {
      final products = await remoteDataSource
          .getLastSeenProducts();
      return Right(products.map((e) => e.toEntity()).toList());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getNewProducts() async {
    try {
      final products = await remoteDataSource.getNewProducts();
      return Right(products.map((e) => e.toEntity()).toList());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Stream<Either<Failure, Product>> getProductDetail(String productId) {
    return remoteDataSource.getProductDetail(GetProductDetailParameter(productId: productId)).map((snapshot) {
      try {
        return Right(ProductModel.fromJson(snapshot.data() as Map<String, dynamic>).toEntity());
      } catch (e) {
        return Left(ServerFailure());
      }
    });
  }
  
  @override
  Future<Either<Failure, void>> addProductToLastSeen(String productId) async {
    try {
      await remoteDataSource.addProductToLastSeen(AddProductToLastSeenParameter(productId: productId));
      return const Right(null);
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }
}
