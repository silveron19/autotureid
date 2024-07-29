import 'package:autotureid/app/domain/entities/product.dart';
import 'package:autotureid/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getNewProducts();
  Stream<Either<Failure, Product>> getProductDetail(String productId);
  Future<Either<Failure, List<Product>>> getLastSeenProducts();
  Future<Either<Failure, void>> addProductToLastSeen(String productId);
}
