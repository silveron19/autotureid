import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/presentation/pages/home/home_page.dart';
import 'package:autotureid/app/presentation/pages/home/product_detail_page.dart';
import 'package:autotureid/app/presentation/pages/profile/edit_profile_page.dart';
import 'package:autotureid/app/presentation/pages/profile/profile_page.dart';
import 'package:autotureid/app/presentation/pages/register/login_screen.dart';
import 'package:autotureid/app/presentation/pages/register/signup_screen.dart';
import 'package:autotureid/app/presentation/pages/scaffold_with_navbar.dart';
import 'package:autotureid/app/presentation/pages/splash_screen.dart';
import 'package:autotureid/app/presentation/pages/subscription/change_payment_method_page.dart';
import 'package:autotureid/app/presentation/pages/subscription/payment_page.dart';
import 'package:autotureid/app/presentation/pages/subscription/subscription_page.dart';
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
    GoRoute(
      path: '/subscription',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SubscriptionPage(),
      routes: [
        GoRoute(
          path: 'payment',
          builder: (context, state) => PaymentPage(
            subscription: state.extra as Subscription,
          ),
          routes: [
            GoRoute(
              path: 'payment-method',
              builder: (context, state) => const ChangePaymentMethodPage(),
            ),
          ],
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // main page will have navbar
        if (state.fullPath == '/home' ||
            state.fullPath == '/arture' ||
            state.fullPath == '/profile') {
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
                // GoRoute(
                //   path: 'subscription',
                //   builder: (context, state) => const SubscriptionPage(),
                //   routes: [
                //     GoRoute(
                //       path: 'payment',
                //       builder: (context, state) => PaymentPage(
                //         subscription: state.extra as Subscription,
                //       ),
                //       routes: [
                //         GoRoute(
                //           path: 'payment-method',
                //           builder: (context, state) => const ChangePaymentMethodPage(),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                GoRoute(
                  path: 'detail/:id',
                  builder: (context, state) => ProductDetailPage(
                    id: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/arture',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: 'edit',
                  builder: (context, state) => const EditProfilePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
