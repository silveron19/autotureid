import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/app/presentation/widgets/subscription/premium_benefit_field.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/utils/parse_date.dart';
import 'package:autotureid/core/utils/parse_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({
    super.key,
    required this.subscription,
  });

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final buttonText = subscription.expiredAt == null
        ? 'Beli'
        : '${ParseDate.calculateDaysLeftFromNow(subscription.expiredAt!)} hari lagi';
    final codePaymentExist = subscription.paymentCode != null;
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
              if (codePaymentExist)
                Text(
                  ParsePrice.parsePriceToRupiah(subscription.price!),
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
              color: color.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: codePaymentExist
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              subscription.paymentCode!,
                              style: kTitle4TextStyle,
                            ),
                            const Text(
                              'Kode Pembayaran',
                              style: kSubtitle5TextStyle,
                            ),
                          ],
                        ),
                        PrimaryElevatedButton(
                          text: 'Salin Kode',
                          dense: true,
                          white: true,
                          borderRadius: 100,
                          onPressed: () async {
                            await Clipboard.setData(
                              ClipboardData(
                                text: subscription.paymentCode!,
                              ),
                            );
                            Fluttertoast.showToast(
                              msg: 'Kode pembayaran berhasil disalin',
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          },
                        ),
                      ],
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: subscription.premiumBenefits
                              .map(
                                (e) => PremiumBenefitField(premiumBenefit: e),
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
                          if (subscription.expiredAt == null) {
                            context.push('/home/subscription/detail', extra: subscription);
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
