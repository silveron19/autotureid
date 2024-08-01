import 'package:autotureid/app/presentation/provider/subscription_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/subscription/payment_method_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChangePaymentMethodPage extends StatefulWidget {
  const ChangePaymentMethodPage({super.key});

  @override
  State<ChangePaymentMethodPage> createState() => _ChangePaymentMethodPageState();
}

class _ChangePaymentMethodPageState extends State<ChangePaymentMethodPage> {
  @override
  void initState() {
    Provider.of<SubscriptionNotifier>(context, listen: false).changePaymentMethodState.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SubscriptionNotifier>(
      builder: (context, notifier, child) {
        final state = notifier.changePaymentMethodState;
        final paymentMethodList = notifier.getPaymentMethodsState.value!;
        if (state.isSuccess()) {
          Fluttertoast.showToast(
            msg: 'Berhasil mengubah metode pembayaran',
            toastLength: Toast.LENGTH_SHORT,
          );
          Future.microtask(() => context.pop());
        } else if (state.isError()) {
          Fluttertoast.showToast(
            msg: 'Berhasil mengubah metode pembayaran',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text('Ubah Metode Pembayaran'),
              ),
              body: ListView.builder(
                itemCount: paymentMethodList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PaymentMethodTile(paymentMethod: paymentMethodList[index]);
                },
              ),
            ),
            if (state.isLoading())
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const CircularLoadingIndicator(),
              ),
          ],
        );
      },
    );
  }
}
