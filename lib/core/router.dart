import 'package:autotureid/app/presentation/pages/home_page.dart';
import 'package:autotureid/app/presentation/pages/register/login_screen.dart';
import 'package:autotureid/app/presentation/pages/register/signup_screen.dart';
import 'package:autotureid/app/presentation/pages/scaffold_with_navbar.dart';
import 'package:autotureid/app/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // main page will have navbar
        if (state.fullPath == '/home' ||
            state.fullPath == '/news' ||
            state.fullPath == '/chatbot') {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        }
        // other page will not have navbar
        return Scaffold(
          body: Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 480,
              ),
              child: navigationShell,
            ),
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/news',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chatbot',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
