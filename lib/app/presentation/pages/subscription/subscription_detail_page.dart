import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/app/presentation/widgets/subscription/subscription_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SubscriptionDetailPage extends StatelessWidget {
  const SubscriptionDetailPage({super.key, required this.subscription});

  final Subscription subscription;

  @override
  Widget build(BuildContext context) {
    final paymentDeadline = DateFormat('dd MMMM yyyy').format(subscription.paymentDeadline!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: kGreenColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Perintah pembayaran Anda berhasil dibuat!',
                        style: kTitle6TextStyle,
                      ),
                      Text(
                        'Harap selesaikan pembayaran Anda dengan informasi berikut paling lambat tanggal $paymentDeadline. Setelah Anda membayar, harap menunggu 1x24 jam, selamat Anda telah tergabung dalam sekte Premium.',
                        textAlign: TextAlign.justify,
                        style: kSubtitle6TextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(child: SubscriptionCard(subscription: subscription)),
            PrimaryElevatedButton(
              text: 'Selesai',
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
