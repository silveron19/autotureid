import 'package:autotureid/app/presentation/provider/product_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_action_button.dart';
import 'package:autotureid/app/presentation/widgets/home/home_app_bar.dart';
import 'package:autotureid/app/presentation/widgets/home/last_seen_catalog.dart';
import 'package:autotureid/app/presentation/widgets/home/new_prodcut_catalog.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.microtask(() => Provider.of<ProductNotifier>(context, listen: false).getHomeProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: Consumer<ProductNotifier>(
          builder: (context, value, child) {
            final state = value.getHomeProductsState;
            if (state.isLoading() || state.isInitial()) {
              return const CircularLoadingIndicator();
            } else if (state.isError()) {
              return const Text('error');
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryActionButton(
                    text: 'Gabung Premium',
                    onTap: () => context.go('/home/subscription'),
                  ),
                  const NewProductCatalog(),
                  Consumer<ProductNotifier>(
                    builder: (context, value, child) {
                      final state = value.lastSeenProductsState;
                      if (state.isLoading()) {
                        return const CircularLoadingIndicator();
                      }
                      return const LastSeenCatalog();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
