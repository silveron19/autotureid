import 'package:autotureid/app/domain/entities/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String mitraId;
  final String title;
  final String desc;
  final int price;
  final String picture;
  final String model;
  final Timestamp createdAt;

  ProductModel({
    required this.id,
    required this.mitraId,
    required this.title,
    required this.desc,
    required this.price,
    required this.picture,
    required this.model,
    required this.createdAt,
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
      createdAt: json['created_at'],
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
      createdAt: Timestamp.fromDate(product.createdAt),
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
      'created_at': createdAt,
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
      createdAt: createdAt.toDate(),
    );
  }

  ProductModel copyWith({
    String? id,
    String? mitraId,
    String? title,
    String? desc,
    int? price,
    String? picture,
    String? model,
    Timestamp? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      mitraId: mitraId ?? this.mitraId,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      picture: picture ?? this.picture,
      model: model ?? this.model,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
