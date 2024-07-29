import 'package:autotureid/app/presentation/widgets/global/join_premium_button.dart';
import 'package:autotureid/app/presentation/widgets/home/home_app_bar.dart';
import 'package:autotureid/app/presentation/widgets/home/last_seen_catalog.dart';
import 'package:autotureid/app/presentation/widgets/home/new_prodcut_catalog.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JoinPremiumButton(),
              NewProductCatalog(),
              LastSeenCatalog(),
            ],
          ),
        ),
      ),
    );
  }
}
