import 'package:autotureid/app/data/models/product_model.dart';
import 'package:autotureid/app/domain/entities/cart.dart';

class CartModel {
  final String id;
  final ProductModel product;
  final String userId;
  final String quantity;

  CartModel({
    required this.id,
    required this.product,
    required this.userId,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      userId: json['user_id'],
      quantity: json['quantity'],
    );
  }

  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      id: cart.id,
      product: ProductModel.fromEntity(cart.product),
      userId: cart.userId,
      quantity: cart.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'user_id': userId,
      'quantity': quantity,
    };
  }

  Cart toEntity() {
    return Cart(
      id: id,
      product: product.toEntity(),
      userId: userId,
      quantity: quantity,
    );
  }

  CartModel copyWith({
    String? id,
    ProductModel? product,
    String? userId,
    String? quantity,
  }) {
    return CartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
    );
  }
}
