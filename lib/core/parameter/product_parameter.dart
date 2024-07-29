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
