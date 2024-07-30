import 'package:autotureid/app/data/models/product_model.dart';
import 'package:autotureid/core/parameter/product_parameter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getNewProducts();
  Stream<DocumentSnapshot> getProductDetail(GetProductDetailParameter parameter);
  Future<List<ProductModel>> getLastSeenProducts();

  Future<void> addProductToLastSeen(AddProductToLastSeenParameter parameter);

  Future<List<ProductModel>> searchProducts(String query);
}
