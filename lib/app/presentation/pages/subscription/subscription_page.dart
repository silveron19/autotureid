import 'package:autotureid/app/domain/entities/premium_benefit.dart';
import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/presentation/widgets/subscription/active_subscription_card.dart';
import 'package:autotureid/app/presentation/widgets/subscription/available_subscription_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Subscription> activeSubscriptions = [
      // Subscription(
      //   id: '1',
      //   title: 'Premium',
      //   premiumBenefits: [
      //     PremiumBenefit(title: 'Rekomendasi Letak Furniture', isAvailable: true),
      //     PremiumBenefit(title: 'Rekomendasi Furniture', isAvailable: true),
      //     PremiumBenefit(title: 'Customisasi Warna', isAvailable: true),
      //     PremiumBenefit(title: 'Download File 3D Model', isAvailable: false),
      //   ],
      //   expiredAt: DateTime(2024, 8, 30),
      // ),
    ];
    final List<Subscription> availableSubscriptions = [
      Subscription(
        id: '1',
        title: 'Premium',
        // paymentDeadline: DateTime(2024, 7, 30),
        // paymentCode: '1234 2748 9924 4020',
        // price: 1500321,
        premiumBenefits: [
          PremiumBenefit(title: 'Rekomendasi Letak Furniture', isAvailable: true),
          PremiumBenefit(title: 'Rekomendasi Furniture', isAvailable: true),
          PremiumBenefit(title: 'Customisasi Warna', isAvailable: true),
          PremiumBenefit(title: 'Download File 3D Model', isAvailable: false),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Langganan'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActiveSubscriptionCard(
                activeSubscriptions: activeSubscriptions,
              ),
              const SizedBox(height: 8),
              AvailableSubscriptionCard(availableSubscriptions: availableSubscriptions)
            ],
          ),
        ),
      ),
    );
  }
}
