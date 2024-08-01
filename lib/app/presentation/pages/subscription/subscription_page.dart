import 'package:autotureid/app/presentation/provider/subscription_notifier.dart';
import 'package:autotureid/app/presentation/widgets/global/circular_loading_indicator.dart';
import 'package:autotureid/app/presentation/widgets/global/erro_retry_fetch_button.dart';
import 'package:autotureid/app/presentation/widgets/subscription/active_subscription_card.dart';
import 'package:autotureid/app/presentation/widgets/subscription/available_subscription_card.dart';
import 'package:autotureid/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    Provider.of<SubscriptionNotifier>(context, listen: false).getSubscriptionsState.reset();
    Future.microtask(
        () => Provider.of<SubscriptionNotifier>(context, listen: false).getSubscriptions());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Langganan'),
      ),
      body: SafeArea(
        child: Consumer<SubscriptionNotifier>(
          builder: (context, value, child) {
            final state = value.getSubscriptionsState;
            if (state.isLoading() || state.isInitial()) {
              return const CircularLoadingIndicator();
            } else if (state.isError()) {
              return ErrorRetryFetchButton(
                failure: state.failure!,
                onRetry: () => value.getSubscriptions(),
              );
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActiveSubscriptionCard(
                    activeSubscription: value.activeSubscription,
                    userPlan: value.getUserPlanState.value,
                  ),
                  const SizedBox(height: 8),
                  AvailableSubscriptionCard(
                    availableSubscriptions: value.availableSubscriptions,
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
