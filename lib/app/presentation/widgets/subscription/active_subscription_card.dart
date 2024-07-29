import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/presentation/widgets/subscription/magnifier_text_row.dart';
import 'package:autotureid/app/presentation/widgets/subscription/subscription_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class ActiveSubscriptionCard extends StatelessWidget {
  const ActiveSubscriptionCard({
    super.key,
    required this.activeSubscriptions,
  });

  final List<Subscription> activeSubscriptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Langganan Aktif',
          style: TextStyle(
            fontSize: 14,
            fontWeight: kFontweightBold,
          ),
        ),
        const SizedBox(height: 8),
        activeSubscriptions.isEmpty
            ? const MagnifierRowText(text: 'Kamu belum punya paket, nih!')
            : Column(
                children: activeSubscriptions
                    .map(
                      (e) => SubscriptionCard(subscription: e),
                    )
                    .toList(),
              ),
      ],
    );
  }
}

