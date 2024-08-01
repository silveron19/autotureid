import 'package:autotureid/app/data/models/product_model.dart';

class GetAllProductsParameter {
  final String? title;
  final ProductModel? productModel;

  GetAllProductsParameter({
    required this.title,
    required this.productModel,
  });
}

class GetProductDetailParameter {
  final String productId;

  GetProductDetailParameter({required this.productId});
}

class GetLastSeenProductsParameter {
  final List<String> productIds;

  GetLastSeenProductsParameter({required this.productIds});
}

class AddProductToLastSeenParameter {
  final String productId;

  AddProductToLastSeenParameter({required this.productId});
}
