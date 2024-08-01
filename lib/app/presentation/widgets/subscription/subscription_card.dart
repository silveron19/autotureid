import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/domain/entities/user_plan.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/app/presentation/widgets/subscription/premium_benefit_field.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/utils/parse_date.dart';
import 'package:autotureid/core/utils/parse_price.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.subscription,
    this.userPlan,
  });

  final Subscription subscription;
  final UserPlan? userPlan;

  @override
  Widget build(BuildContext context) {
    final buttonText = userPlan?.endDate == null
        ? 'Beli'
        : '${ParseDate.calculateDaysLeftFromNow(userPlan!.endDate!)} hari lagi';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subscription.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: kFontweightBold,
                ),
              ),
              Text(
                ParsePrice.parsePriceToRupiah(subscription.price),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: kFontweightBold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.fromLTRB(
              16,
              kDefaultPadding,
              4,
              kDefaultPadding,
            ),
            decoration: BoxDecoration(
              // color: color.primary,
              image: const DecorationImage(
                image: AssetImage(R.ASSETS_IMAGES_SUBSCRIPTION_CARD_PNG),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: subscription.desc
                        .map(
                          (e) => SubscriptionDescField(subscriptionDesc: e),
                        )
                        .toList(),
                  ),
                ),
                PrimaryElevatedButton(
                  text: buttonText,
                  dense: true,
                  white: true,
                  borderRadius: 100,
                  onPressed: () {
                    if (userPlan?.endDate == null) {
                      context.push('/subscription/payment', extra: subscription);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
