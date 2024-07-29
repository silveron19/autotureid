import 'package:autotureid/app/domain/entities/premium_benefit.dart';

class Subscription {
  final String id;
  final String title;
  final List<PremiumBenefit> premiumBenefits;
  final DateTime? paymentDeadline;
  final DateTime? expiredAt;
  final String? paymentCode;
  final int? price;

  Subscription({
    required this.id,
    required this.title,
    required this.premiumBenefits,
    this.paymentCode,
    this.paymentDeadline,
    this.expiredAt,
    this.price,
  });
}
