import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),
        () => Provider.of<AuthNotifier>(context, listen: false).getUserFromLocal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthNotifier>(
        builder: (context, authNotifier, child) {
          final state = authNotifier.getUserFromLocalState;
          if (state.isSuccess()) {
            Future.microtask(() => context.go('/home'));
          } else if (state.isError()) {
            Future.microtask(() => context.go('/login'));
          }
          return const SafeArea(
            child: Center(
              child: AppLogo(),
            ),
          );
        },
      ),
    );
  }
}
