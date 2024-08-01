import 'package:autotureid/core/enums.dart';

class Payment {
  final String id;
  final String userId;
  final String planId;
  final String paymentMethodId;
  final int amount;
  final DateTime? paymentDate;
  final DateTime? paymentDeadline;
  final int uniqueCode;
  final PaymentStatus status;

  Payment({
    required this.id,
    required this.userId,
    required this.planId,
    required this.paymentMethodId,
    required this.amount,
    required this.paymentDate,
    required this.paymentDeadline,
    required this.uniqueCode,
    required this.status,
  });
}
