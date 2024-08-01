import 'package:autotureid/app/presentation/provider/product_notifier.dart';
import 'package:autotureid/app/presentation/provider/search_notifier.dart';
import 'package:autotureid/app/presentation/provider/subscription_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/erro_retry_fetch_button.dart';
import 'package:autotureid/app/presentation/widgets/global/primary_action_button.dart';
import 'package:autotureid/app/presentation/widgets/home/home_app_bar.dart';
import 'package:autotureid/app/presentation/widgets/home/home_search_layout.dart';
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
    Future.microtask(() => Provider.of<SubscriptionNotifier>(context, listen: false).getUserPlan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(
      builder: (context, searchNotifier, child) {
        return PopScope(
          canPop: !searchNotifier.searchMode,
          onPopInvoked: (didPop) {
            searchNotifier.onSearchModeOff();
          },
          child: Scaffold(
            appBar: const HomeAppBar(),
            body: SafeArea(
              child: Consumer<SubscriptionNotifier>(
                builder: (context, subscriptionNotifier, child) {
                  final state = subscriptionNotifier.getUserPlanState;
                  if (state.isLoading() || state.isInitial()) {
                    return const CircularLoadingIndicator();
                  } else if (state.isError()) {
                    return ErrorRetryFetchButton(
                      failure: state.failure!,
                      onRetry: () => subscriptionNotifier.getUserPlan(),
                    );
                  }
                  return Consumer<ProductNotifier>(
                    builder: (context, value, child) {
                      final state = value.getHomeProductsState;
                      if (state.isLoading() || state.isInitial()) {
                        return const CircularLoadingIndicator();
                      } else if (state.isError()) {
                        return ErrorRetryFetchButton(
                          failure: state.failure!,
                          onRetry: () => value.getHomeProducts(),
                        );
                      }
                      return searchNotifier.searchMode
                          ? const HomeSearchLayout()
                          : SingleChildScrollView(
                              padding: const EdgeInsets.only(top: kDefaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  subscriptionNotifier.getUserPlanState.value!.startDate != null
                                      ? const SizedBox()
                                      : PrimaryActionButton(
                                          text: 'Gabung Premium',
                                          onTap: () => context.push('/subscription'),
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
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
