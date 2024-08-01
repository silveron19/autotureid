import 'package:autotureid/app/domain/entities/payment.dart';
import 'package:autotureid/core/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String planId;
  final String userId;
  final String paymentMethodId;
  final int amount;
  final Timestamp? paymentDate;
  final Timestamp? paymentDeadline;
  final int uniqueCode;
  final String status;

  PaymentModel({
    required this.id,
    required this.planId,
    required this.userId,
    required this.paymentMethodId,
    required this.amount,
    required this.paymentDate,
    required this.paymentDeadline,
    required this.uniqueCode,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      planId: json['plan_id'],
      userId: json['user_id'],
      paymentMethodId: json['payment_method_id'],
      amount: json['amount'],
      paymentDate: json['payment_date'],
      paymentDeadline: json['payment_deadline'],
      uniqueCode: json['unique_code'],
      status: json['status'],
    );
  }

  factory PaymentModel.fromEntity(Payment entity) {
    return PaymentModel(
      id: entity.id,
      planId: entity.planId,
      userId: entity.userId,
      paymentMethodId: entity.paymentMethodId,
      amount: entity.amount,
      paymentDate: entity.paymentDate != null ? Timestamp.fromDate(entity.paymentDate!) : null,
      paymentDeadline:
          entity.paymentDeadline != null ? Timestamp.fromDate(entity.paymentDeadline!) : null,
      uniqueCode: entity.uniqueCode,
      status: entity.status.name,
    );
  }

  Payment toEntity() {
    return Payment(
      id: id,
      planId: planId,
      userId: userId,
      paymentMethodId: paymentMethodId,
      amount: amount,
      paymentDate: paymentDate?.toDate(),
      paymentDeadline: paymentDeadline?.toDate(),
      uniqueCode: uniqueCode,
      status: PaymentStatus.values.firstWhere((e) => e.name == status),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_id': planId,
      'user_id': userId,
      'payment_method_id': paymentMethodId,
      'amount': amount,
      'payment_date': paymentDate,
      'payment_deadline': paymentDeadline,
      'unique_code': uniqueCode,
      'status': status,
    };
  }

  PaymentModel copyWith({
    String? id,
    String? planId,
    String? userId,
    String? paymentMethodId,
    int? amount,
    Timestamp? paymentDate,
    Timestamp? paymentDeadline,
    int? uniqueCode,
    String? status,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      userId: userId ?? this.userId,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentDeadline: paymentDeadline ?? this.paymentDeadline,
      uniqueCode: uniqueCode ?? this.uniqueCode,
      status: status ?? this.status,
    );
  }
}
