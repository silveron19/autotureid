import 'package:autotureid/app/domain/entities/payment.dart';
import 'package:autotureid/app/domain/entities/payment_method.dart';
import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/domain/entities/user_plan.dart';
import 'package:autotureid/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, List<Subscription>>> getSubscriptions();
  Future<Either<Failure, UserPlan>> getUserPlan();

  Future<Either<Failure, Payment>> createPayment(Subscription subscription);
  Future<Either<Failure, Payment>> getPayment(Subscription subscription);
  Future<Either<Failure, Payment>> changePaymentMethod(
    Payment payment,
    String paymentMethodId,
  );
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods();
}
