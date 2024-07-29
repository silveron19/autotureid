import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/presentation/widgets/subscription/magnifier_text_row.dart';
import 'package:autotureid/app/presentation/widgets/subscription/subscription_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class AvailableSubscriptionCard extends StatelessWidget {
  const AvailableSubscriptionCard({
    super.key,
    required this.availableSubscriptions,
  });

  final List<Subscription> availableSubscriptions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Langganan Untuk Kamu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: kFontweightBold,
            ),
          ),
          const SizedBox(height: 8),
          availableSubscriptions.isEmpty
              ? const MagnifierRowText(text: 'Tungguin aja, paketnya lagi disiapin')
              : Column(
                  children: availableSubscriptions
                      .map(
                        (e) => SubscriptionCard(subscription: e),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}