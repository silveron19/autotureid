import 'dart:io';

import 'package:autotureid/app/data/datasources/abstracts/subscription/subscription_remote_data_source.dart';
import 'package:autotureid/app/data/models/payment_model.dart';
import 'package:autotureid/app/data/models/subscription_model.dart';
import 'package:autotureid/app/domain/entities/payment.dart';
import 'package:autotureid/app/domain/entities/payment_method.dart';
import 'package:autotureid/app/domain/entities/subscription.dart';
import 'package:autotureid/app/domain/entities/user_plan.dart';
import 'package:autotureid/app/domain/repositories/subscription_repository.dart';
import 'package:autotureid/core/custom_exception.dart';
import 'package:autotureid/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Payment>> changePaymentMethod(
      Payment payment, String paymentMethodId) async {
    try {
      final newPayment = await remoteDataSource.changePaymentMethod(
          PaymentModel.fromEntity(payment), paymentMethodId);
      return Right(newPayment.toEntity());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Payment>> createPayment(Subscription subscription) async {
    try {
      final payment =
          await remoteDataSource.createPayment(SubscriptionModel.fromEntity(subscription));
      return Right(payment.toEntity());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Payment>> getPayment(Subscription subscription) async {
    try {
      final payment = await remoteDataSource.getPayment(SubscriptionModel.fromEntity(subscription));
      return Right(payment.toEntity());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    try {
      final paymentMethods = await remoteDataSource.getPaymentMethods();
      return Right(paymentMethods.map((e) => e.toEntity()).toList());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Subscription>>> getSubscriptions() async {
    try {
      final subscriptions = await remoteDataSource.getSubscriptions();
      return Right(subscriptions.map((e) => e.toEntity()).toList());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserPlan>> getUserPlan() async {
    try {
      final userPlan = await remoteDataSource.getUserPlan();
      return Right(userPlan.toEntity());
    } on SocketException {
      return Left(ConnectionFailure());
    } on HandshakeException {
      return Left(ConnectionFailure());
    } on ClientException {
      return Left(ConnectionFailure());
    } on CustomException catch (e) {
      return Left(
        BadRequestFailure(
          message: e.message,
        ),
      );
    }
  }
}
