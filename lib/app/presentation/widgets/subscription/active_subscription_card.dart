import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/domain/entities/user_plan.dart';
import 'package:autotureid/app/presentation/widgets/subscription/magnifier_text_row.dart';
import 'package:autotureid/app/presentation/widgets/subscription/subscription_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class ActiveSubscriptionCard extends StatelessWidget {
  const ActiveSubscriptionCard({
    super.key,
    required this.activeSubscription,
    this.userPlan,
  });

  final Subscription? activeSubscription;
  final UserPlan? userPlan;

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
        activeSubscription == null
            ? const MagnifierRowText(text: 'Kamu belum punya paket, nih!')
            : SubscriptionCard(
                subscription: activeSubscription!,
                userPlan: userPlan,
              ),
      ],
    );
  }
}
