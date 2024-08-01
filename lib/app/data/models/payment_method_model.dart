import 'package:autotureid/app/domain/entities/payment_method.dart';

class PaymentMethodModel {
  final String id;
  final String name;
  final String accountNumber;
  final String picture;

  PaymentMethodModel({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.picture,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
      accountNumber: json['account_number'],
      picture: json['picture'],
    );
  }

  factory PaymentMethodModel.fromEntity(PaymentMethod entity) {
    return PaymentMethodModel(
      id: entity.id,
      name: entity.name,
      accountNumber: entity.accountNumber,
      picture: entity.picture,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'account_number': accountNumber,
      'picture': picture,
    };
  }

  PaymentMethod toEntity() {
    return PaymentMethod(
      id: id,
      name: name,
      accountNumber: accountNumber,
      picture: picture,
    );
  }
}
