import 'package:autotureid/app/domain/entities/payment_method.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/const/resource.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PaymentCodeCard extends StatelessWidget {
  const PaymentCodeCard({
    super.key,
    required this.paymentMethod,
  });

  final PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        kDefaultPadding,
        4,
        kDefaultPadding,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(R.ASSETS_IMAGES_SUBSCRIPTION_CARD_PNG),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  paymentMethod.accountNumber,
                  style: kTitle4TextStyle.copyWith(color: Colors.black),
                ),
                Text(
                  'Kode Pembayaran',
                  style: kSubtitle5TextStyle.copyWith(color: Colors.black),
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
                    text: paymentMethod.accountNumber,
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
      ),
    );
  }
}
