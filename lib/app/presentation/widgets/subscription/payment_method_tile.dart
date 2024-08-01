import 'package:autotureid/app/domain/entities/payment_method.dart';
import 'package:autotureid/app/presentation/provider/subscription_notifier.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.paymentMethod,
  });

  final PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<SubscriptionNotifier>(context, listen: false);
    final payment = notifier.getPaymentState.value!;
    return GestureDetector(
      onTap: () => notifier.changePaymentMethod(payment, paymentMethod.id),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: kDefaultPadding,
        ),
        color: Colors.transparent,
        child: Row(
          children: [
            Image.network(
              paymentMethod.picture,
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 8),
            Text(
              paymentMethod.name,
              style: kTitle4TextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
