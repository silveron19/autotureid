import 'package:autotureid/app/domain/entities/subscription_desc.dart';

class Subscription {
  final String id;
  final String type;
  final String title;
  final List<SubscriptionDesc> desc;
  final int price;

  Subscription({
    required this.id,
    required this.type,
    required this.title,
    required this.desc,
    required this.price,
  });
}
