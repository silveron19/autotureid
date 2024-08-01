import 'package:autotureid/app/data/models/payment_method_model.dart';
import 'package:autotureid/app/data/models/payment_model.dart';
import 'package:autotureid/app/data/models/subscription_model.dart';
import 'package:autotureid/app/data/models/user_plan_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<List<SubscriptionModel>> getSubscriptions();
  Future<UserPlanModel> getUserPlan();

  Future<PaymentModel> createPayment(SubscriptionModel subscription);
  Future<PaymentModel> getPayment(SubscriptionModel subscription);
  Future<PaymentModel> changePaymentMethod(
    PaymentModel payment,
    String paymentMethodId,
  );
  Future<List<PaymentMethodModel>> getPaymentMethods();
}
