import 'package:autotureid/app/domain/entities/product.dart';

class ProductModel {
  final String id;
  final String mitraId;
  final String title;
  final String desc;
  final String price;
  final String picture;
  final String model;

  ProductModel({
    required this.id,
    required this.mitraId,
    required this.title,
    required this.desc,
    required this.price,
    required this.picture,
    required this.model,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      mitraId: json['mitra_id'],
      title: json['title'],
      desc: json['desc'],
      price: json['price'],
      picture: json['picture'],
      model: json['model'],
    );
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      mitraId: product.mitraId,
      title: product.title,
      desc: product.desc,
      price: product.price,
      picture: product.picture,
      model: product.model,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mitra_id': mitraId,
      'title': title,
      'desc': desc,
      'price': price,
      'picture': picture,
      'model': model,
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      mitraId: mitraId,
      title: title,
      desc: desc,
      price: price,
      picture: picture,
      model: model,
    );
  }

  ProductModel copyWith({
    String? id,
    String? mitraId,
    String? title,
    String? desc,
    String? price,
    String? picture,
    String? model,
  }) {
    return ProductModel(
      id: id ?? this.id,
      mitraId: mitraId ?? this.mitraId,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      picture: picture ?? this.picture,
      model: model ?? this.model,
    );
  }
}
