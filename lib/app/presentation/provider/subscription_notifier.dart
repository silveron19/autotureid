import 'package:autotureid/app/domain/entities/payment.dart';
import 'package:autotureid/app/domain/entities/payment_method.dart';
import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/domain/entities/user_plan.dart';
import 'package:autotureid/app/domain/repositories/subscription_repository.dart';
import 'package:autotureid/core/utils/notifier_state.dart';
import 'package:flutter/material.dart';

class SubscriptionNotifier extends ChangeNotifier {
  final SubscriptionRepository subscriptionRepository;

  SubscriptionNotifier({required this.subscriptionRepository});

  NotifierState<List<Subscription>> getSubscriptionsState = NotifierState();
  NotifierState<UserPlan> getUserPlanState = NotifierState();
  NotifierState<Payment> createPaymentState = NotifierState();
  NotifierState<Payment> getPaymentState = NotifierState();
  NotifierState<Payment> changePaymentMethodState = NotifierState();

  NotifierState<List<PaymentMethod>> getPaymentMethodsState = NotifierState();

  late PaymentMethod selectedPaymentMethod;

  Subscription? activeSubscription;
  List<Subscription> availableSubscriptions = [];

  void getSubscriptions() async {
    getSubscriptionsState.setLoading();
    notifyListeners();

    final result = await subscriptionRepository.getSubscriptions();

    result.fold(
      (failure) {
        getSubscriptionsState.setError(error: failure.message);
      },
      (subscriptions) {
        activeSubscription = null;
        availableSubscriptions = [];
        getSubscriptionsState.setSuccess(value: subscriptions);
        for (var subscription in subscriptions) {
          if (subscription.id == getUserPlanState.value!.planId) {
            activeSubscription = subscription;
          } else {
            availableSubscriptions.add(subscription);
          }
        }
      },
    );

    notifyListeners();
  }

  void getUserPlan() async {
    getUserPlanState.setLoading();
    notifyListeners();

    final result = await subscriptionRepository.getUserPlan();

    result.fold(
      (failure) {
        getUserPlanState.setError(error: failure.message);
      },
      (userPlan) {
        getUserPlanState.setSuccess(value: userPlan);
      },
    );

    notifyListeners();
  }

  void createPayment(Subscription subscription) async {
    createPaymentState.setLoading();
    notifyListeners();

    final result = await subscriptionRepository.createPayment(subscription);

    result.fold(
      (failure) {
        createPaymentState.setError(error: failure.message);
      },
      (payment) {
        createPaymentState.setSuccess(value: payment);
      },
    );

    notifyListeners();
  }

  void getPayment(Subscription subscription) async {
    getPaymentState.setLoading();
    notifyListeners();

    await getPaymentMethods();

    if (getPaymentMethodsState.isError()) {
      getPaymentState.setError(error: getPaymentMethodsState.failure!);
      notifyListeners();
      return;
    }

    final result = await subscriptionRepository.getPayment(subscription);

    result.fold(
      (failure) {
        getPaymentState.setError(error: failure.message);
      },
      (payment) {
        getPaymentState.setSuccess(value: payment);
        selectedPaymentMethod = getPaymentMethodsState.value!
            .firstWhere((element) => element.id == payment.paymentMethodId);
      },
    );

    notifyListeners();
  }

  void changePaymentMethod(Payment payment, String paymentMethodId) async {
    changePaymentMethodState.setLoading();
    notifyListeners();

    final result = await subscriptionRepository.changePaymentMethod(payment, paymentMethodId);

    result.fold(
      (failure) {
        changePaymentMethodState.setError(error: failure.message);
      },
      (payment) {
        changePaymentMethodState.setSuccess(value: payment);
        selectedPaymentMethod = getPaymentMethodsState.value!
            .firstWhere((element) => element.id == payment.paymentMethodId);
      },
    );

    notifyListeners();
  }

  Future<void> getPaymentMethods() async {
    getPaymentMethodsState.setLoading();
    notifyListeners();

    final result = await subscriptionRepository.getPaymentMethods();

    result.fold(
      (failure) {
        getPaymentMethodsState.setError(error: failure.message);
      },
      (paymentMethods) {
        getPaymentMethodsState.setSuccess(value: paymentMethods);
      },
    );

    notifyListeners();
  }
}
