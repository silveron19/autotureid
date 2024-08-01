import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/presentation/provider/subscription_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/erro_retry_fetch_button.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/app/presentation/widgets/subscription/payment_code_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/utils/parse_price.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
    required this.subscription,
  });

  final Subscription subscription;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    Provider.of<SubscriptionNotifier>(context, listen: false).getPaymentState.reset();
    Future.microtask(() =>
        Provider.of<SubscriptionNotifier>(context, listen: false).getPayment(widget.subscription));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pembayaran'),
      ),
      body: Consumer<SubscriptionNotifier>(
        builder: (context, notifier, child) {
          final state = notifier.getPaymentState;
          if (state.isLoading() || state.isInitial()) {
            return const CircularLoadingIndicator();
          } else if (state.isError()) {
            return ErrorRetryFetchButton(
              failure: state.failure!,
              onRetry: () => notifier.getPayment(widget.subscription),
            );
          }

          final payment = notifier.getPaymentState.value!;
          final paymentMethod = notifier.selectedPaymentMethod;
          final deadline = DateFormat('dd MMMM yyyy').format(payment.paymentDeadline!);
          return Padding(
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
                            'Harap selesaikan pembayaran Anda dengan informasi berikut paling lambat tanggal $deadline. Setelah Anda membayar, harap menunggu 1x24 jam, selamat Anda telah tergabung dalam sekte Premium.',
                            textAlign: TextAlign.justify,
                            style: kSubtitle6TextStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.subscription.title,
                      style: kTitle4TextStyle,
                    ),
                    Text(
                      ParsePrice.parsePriceToRupiah(widget.subscription.price),
                      style: kTitle4TextStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => context.push('/subscription/payment/payment-method'),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Text(
                          'Metode Pembayaran',
                          style: kTitle4TextStyle,
                        ),
                      ),
                      Image.network(
                        paymentMethod.picture,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        paymentMethod.name,
                        style: kTitle4TextStyle,
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        weight: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                PaymentCodeCard(paymentMethod: paymentMethod),
                const Spacer(),
                PrimaryElevatedButton(
                  text: 'Selesai',
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
