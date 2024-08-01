import 'package:autotureid/app/domain/entities/subscription_desc.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class SubscriptionDescField extends StatelessWidget {
  const SubscriptionDescField({
    super.key,
    required this.subscriptionDesc,
  });

  final SubscriptionDesc subscriptionDesc;

  @override
  Widget build(BuildContext context) {
    final benefitIcon = subscriptionDesc.isAvailable ? '✅' : '❌';
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$benefitIcon ',
            style: const TextStyle(
              fontWeight: kFontweightBold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              subscriptionDesc.title,
              style: const TextStyle(
                fontWeight: kFontweightBold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
