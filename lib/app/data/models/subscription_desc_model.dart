import 'package:autotureid/app/domain/entities/subscription_desc.dart';

class SubscriptionDescModel {
  final String title;
  final bool isAvailable;

  SubscriptionDescModel({
    required this.title,
    required this.isAvailable,
  });

  factory SubscriptionDescModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionDescModel(
      title: json['text'],
      isAvailable: json['is_enable'],
    );
  }

  factory SubscriptionDescModel.fromEntity(SubscriptionDesc entity) {
    return SubscriptionDescModel(
      title: entity.title,
      isAvailable: entity.isAvailable,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'is_available': isAvailable,
    };
  }

  SubscriptionDesc toEntity() {
    return SubscriptionDesc(
      title: title,
      isAvailable: isAvailable,
    );
  }
}
