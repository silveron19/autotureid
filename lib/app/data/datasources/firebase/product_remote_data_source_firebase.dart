import 'package:autotureid/app/data/datasources/abstracts/product/product_remote_data_source.dart';
import 'package:autotureid/app/data/models/product_model.dart';
import 'package:autotureid/core/parameter/product_parameter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRemoteDataSourceFirebase extends ProductRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ProductRemoteDataSourceFirebase({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<List<ProductModel>> getLastSeenProducts() async {
    // get user last seen products from firestore
    final user = auth.currentUser!;
    final doc = firestore.collection('users').doc(user.uid);
    final snapshot = await doc.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;
      final List<String> lastSeenProducts = List<String>.from(data['last_seen_products']);
      if (lastSeenProducts.isEmpty) {
        return [];
      }
      final snapshots =
          await firestore.collection('products').where('id', whereIn: lastSeenProducts).get();
      return snapshots.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    }
    return [];
  }

  @override
  Future<List<ProductModel>> getNewProducts() async {
    QuerySnapshot snapshot = await firestore
        .collection('products')
        .where('created_at',
            isGreaterThanOrEqualTo:
                DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch)
        .limit(10)
        .get();
    return snapshot.docs
        .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Stream<DocumentSnapshot<Object?>> getProductDetail(GetProductDetailParameter parameter) {
    return firestore.collection('products').doc(parameter.productId).snapshots();
  }

  @override
  Future<void> addProductToLastSeen(AddProductToLastSeenParameter parameter) async {
    // get user last seen products on firestore, if the length is 5, delete the first id then add the new id. update the last seen products on firestore
    final user = auth.currentUser;
    if (user != null) {
      final doc = firestore.collection('users').doc(user.uid);
      final snapshot = await doc.get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        List<String> lastSeenProducts = List<String>.from(data['last_seen_products']);
        // if the id is already in the list, remove it first then add it to the end
        if (lastSeenProducts.contains(parameter.productId)) {
          lastSeenProducts.remove(parameter.productId);
        } else if (lastSeenProducts.length == 5) {
          lastSeenProducts.removeAt(0);
        }
        lastSeenProducts.add(parameter.productId);
        await doc.update({'last_seen_products': lastSeenProducts});
      } else {
        await doc.set({
          'last_seen_products': [parameter.productId]
        });
      }
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    QuerySnapshot snapshot = await firestore
        .collection('products')
        .where('title_lower', isGreaterThanOrEqualTo: query)
        .where('title_lower', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(10)
        .get();
    return snapshot.docs
        .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }
}
