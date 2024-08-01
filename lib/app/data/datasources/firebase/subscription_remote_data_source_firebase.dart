import 'package:autotureid/app/data/datasources/abstracts/subscription/subscription_remote_data_source.dart';
import 'package:autotureid/app/data/models/payment_method_model.dart';
import 'package:autotureid/app/data/models/payment_model.dart';
import 'package:autotureid/app/data/models/subscription_model.dart';
import 'package:autotureid/app/data/models/user_plan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SubscriptionRemoteDataSourceFirebase implements SubscriptionRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  SubscriptionRemoteDataSourceFirebase({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<PaymentModel> changePaymentMethod(
    PaymentModel payment,
    String paymentMethodId,
  ) async {
    // get the payment document
    final docRef = firebaseFirestore.collection('payments').doc(payment.id);

    // update the payment method
    await docRef.update({
      'payment_method_id': paymentMethodId,
    });

    // update payment
    final newPayment = payment.copyWith(paymentMethodId: paymentMethodId);

    return newPayment;
  }

  @override
  Future<PaymentModel> createPayment(SubscriptionModel subscription) async {
    final userId = firebaseAuth.currentUser!.uid;
    final paymentRef = firebaseFirestore.collection('payments').doc();

    // get the first payment method from firestore
    final paymentMethodSnapshot =
        await firebaseFirestore.collection('payment_methods').limit(1).get();

    final paymentMethod = PaymentMethodModel.fromJson(paymentMethodSnapshot.docs.first.data());

    // generate random unique code with 3 digit from 100 to 300
    final uniqueCode = 100 + (DateTime.now().millisecondsSinceEpoch % 200);

    final payment = PaymentModel(
      id: paymentRef.id,
      planId: subscription.id,
      userId: userId,
      paymentMethodId: paymentMethod.id,
      amount: subscription.price + uniqueCode,
      paymentDate: null,
      paymentDeadline: Timestamp.fromDate(DateTime.now().add(const Duration(days: 7))),
      uniqueCode: uniqueCode,
      status: 'pending',
    );

    await paymentRef.set(payment.toJson());

    return payment;
  }

  @override
  Future<PaymentModel> getPayment(SubscriptionModel subscription) async {
    late PaymentModel payment;
    final userId = firebaseAuth.currentUser!.uid;

    final paymentSnapshot = await firebaseFirestore
        .collection('payments')
        .where('user_id', isEqualTo: userId)
        .where('plan_id', isEqualTo: subscription.id)
        .get();

    if (paymentSnapshot.docs.isEmpty) {
      payment = await createPayment(subscription);
      return payment;
    } else {
      payment = PaymentModel.fromJson(paymentSnapshot.docs.first.data());
      // if user payment deadline has pass, update the payment deadline
      if (payment.paymentDeadline!.toDate().isBefore(DateTime.now())) {
        final newPaymentDeadline = Timestamp.fromDate(DateTime.now().add(const Duration(days: 7)));
        await paymentSnapshot.docs.first.reference.update({
          'payment_deadline': newPaymentDeadline,
        });
        payment = payment.copyWith(paymentDeadline: newPaymentDeadline);
      }
      return payment;
    }
  }

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final paymentMethodsSnapshot = await firebaseFirestore.collection('payment_methods').get();

    final paymentMethods =
        paymentMethodsSnapshot.docs.map((doc) => PaymentMethodModel.fromJson(doc.data())).toList();

    return paymentMethods;
  }

  @override
  Future<List<SubscriptionModel>> getSubscriptions() async {
    final subscriptionsSnapshot =
        await firebaseFirestore.collection('plans').where('type', isNotEqualTo: 'basic').get();

    final subscriptions =
        subscriptionsSnapshot.docs.map((doc) => SubscriptionModel.fromJson(doc.data())).toList();

    return subscriptions;
  }

  @override
  Future<UserPlanModel> getUserPlan() async {
    final userId = firebaseAuth.currentUser!.uid;

    final userPlanSnapshot =
        await firebaseFirestore.collection('user_plans').where('user_id', isEqualTo: userId).get();

    final userPlan = UserPlanModel.fromJson(userPlanSnapshot.docs.first.data());

    return userPlan;
  }
}
