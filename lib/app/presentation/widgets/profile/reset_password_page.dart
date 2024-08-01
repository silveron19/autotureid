import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_elevated_button.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  void initState() {
    Provider.of<AuthNotifier>(context, listen: false).resetPasswordState.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Password'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              const Text(
                'Link untuk mengganti password akan dikirm ke email yang terdaftar di akun Anda',
                style: kSubtitle5TextStyle,
              ),
              const SizedBox(height: 16),
              Consumer<AuthNotifier>(
                builder: (context, auth, child) {
                  final state = auth.resetPasswordState;
                  if (state.isLoading()) {
                    return const CircularLoadingIndicator();
                  } else if (state.isError()) {
                    Fluttertoast.showToast(
                      msg: state.failure!,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  } else if (state.isSuccess()) {
                    Fluttertoast.showToast(
                      msg: 'Silakan cek email Anda untuk mengganti password',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                  return PrimaryElevatedButton(
                    text: 'Kirim ke Email',
                    onPressed: () => auth.resetPassword(null),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
