import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/app_logo.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/input/text_input_column.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_outlined_button.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (formKey.currentState!.validate()) {
      Provider.of<AuthNotifier>(context, listen: false).signup(
        usernameController.text,
        emailController.text,
        passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const AppLogo(),
                Text(
                  'Daftar Akun Autoture',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: kFontweightBold,
                    color: color.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                TextInputColumn(
                  text: 'Username',
                  controller: usernameController,
                  hintText: 'Masukkan Username',
                  validator: (value) => value.isEmpty,
                  validatorText: 'Username harus diisi',
                ),
                TextInputColumn(
                  text: 'Email',
                  controller: emailController,
                  hintText: 'Masukkan Email',
                  email: true,
                  validator: (value) => value.isEmpty,
                  validatorText: 'Email harus diisi',
                ),
                TextInputColumn(
                  text: 'Password',
                  controller: passwordController,
                  hintText: 'Masukkan Password',
                  isPassword: true,
                  validator: (value) => value.isEmpty,
                  validatorText: 'Password harus diisi',
                  onComplete: onSubmit,
                ),
                const SizedBox(height: kDefaultPadding),
                Consumer<AuthNotifier>(
                  builder: (context, value, child) {
                    final state = value.signupState;
                    if (state.isLoading()) {
                      return const CircularLoadingIndicator();
                    } else if (state.isError()) {
                      Fluttertoast.showToast(
                        msg: state.failure!,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (state.isSuccess()) {
                      Future.microtask(() => context.go('/home'));
                    }
                    return PrimaryOutlinedButton(
                      text: 'Buat Akun',
                      onPressed: onSubmit,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Sudah punya akun? ',
                      style: TextStyle(
                        color: color.onBackground,
                        fontSize: 14,
                        fontWeight: kFontweightBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          color: color.primary,
                          fontSize: 14,
                          fontWeight: kFontweightBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
