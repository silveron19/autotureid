import 'package:autotureid/app/presentation/widgets/global/primary_action_button.dart';
import 'package:autotureid/app/presentation/widgets/home/home_app_bar.dart';
import 'package:autotureid/app/presentation/widgets/home/last_seen_catalog.dart';
import 'package:autotureid/app/presentation/widgets/home/new_prodcut_catalog.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryActionButton(
                text: 'Gabung Premium',
                onTap: () => context.go('/home/subscription'),
              ),
              const NewProductCatalog(),
              const LastSeenCatalog(),
            ],
          ),
        ),
      ),
    );
  }
}
