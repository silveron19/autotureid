import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:autotureid/app/presentation/provider/product_notifier.dart';
import 'package:autotureid/app/presentation/provider/search_notifier.dart';
import 'package:autotureid/core/constants.dart';
import 'package:autotureid/core/router.dart';
import 'package:autotureid/core/theme.dart';
import 'package:autotureid/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AuthNotifier>()),
        ChangeNotifierProvider(create: (_) => di.sl<ProductNotifier>()),
        ChangeNotifierProvider(create: (_) => di.sl<SearchNotifier>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: kAppName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
      ),
    );
  }
}
