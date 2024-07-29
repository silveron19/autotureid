import 'package:autotureid/app/domain/entities/premium_benefit.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class PremiumBenefitField extends StatelessWidget {
  const PremiumBenefitField({
    super.key,
    required this.premiumBenefit,
  });

  final PremiumBenefit premiumBenefit;

  @override
  Widget build(BuildContext context) {
    final benefitIcon = premiumBenefit.isAvailable ? '✅' : '❌';
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
          Expanded(
            child: Text(
              premiumBenefit.title,
              style: const TextStyle(
                fontWeight: kFontweightBold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
