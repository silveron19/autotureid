import 'package:autotureid/app/data/models/subscription_desc_model.dart';
import 'package:autotureid/app/domain/entities/subscription.dart';

class SubscriptionModel {
  final String id;
  final String type;
  final String title;
  final List<SubscriptionDescModel> desc;
  final int price;

  SubscriptionModel({
    required this.id,
    required this.type,
    required this.title,
    required this.desc,
    required this.price,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      desc: (json['desc'] as List).map((e) => SubscriptionDescModel.fromJson(e)).toList(),
      price: json['price'],
    );
  }

  factory SubscriptionModel.fromEntity(Subscription entity) {
    return SubscriptionModel(
      id: entity.id,
      type: entity.type,
      title: entity.title,
      desc: entity.desc.map((e) => SubscriptionDescModel.fromEntity(e)).toList(),
      price: entity.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'desc': desc.map((e) => e.toJson()).toList(),
      'price': price,
    };
  }

  Subscription toEntity() {
    return Subscription(
      id: id,
      type: type,
      title: title,
      desc: desc.map((e) => e.toEntity()).toList(),
      price: price,
    );
  }
}
