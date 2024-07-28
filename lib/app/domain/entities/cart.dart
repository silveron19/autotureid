import 'package:autotureid/app/domain/entities/product.dart';

class Cart {
  final String id;
  final Product product;
  final String userId;
  final String quantity;

  Cart({
    required this.id,
    required this.product,
    required this.userId,
    required this.quantity,
  });
}
