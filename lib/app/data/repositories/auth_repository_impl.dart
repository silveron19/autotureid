import 'dart:io';

import 'package:autotureid/app/data/datasources/abstracts/auth/auth_local_data_source.dart';
import 'package:autotureid/app/data/datasources/abstracts/auth/auth_remote_data_source.dart';
import 'package:autotureid/app/data/models/user_data_model.dart';
import 'package:autotureid/app/domain/entities/user_data.dart';
import 'package:autotureid/app/domain/repositories/auth_repository.dart';
import 'package:autotureid/core/custom_exception.dart';
import 'package:autotureid/core/failure.dart';
import 'package:autotureid/core/parameter/auth_parameter.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> cacheToLocal(UserData userData) async {
    await localDataSource.cacheToLocal(UserDataModel.fromEntity(userData));
  }

  @override
  UserData? getFromLocal() {
    final user = localDataSource.getFromLocal();
    if (user != null) {
      return user.toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<Either<Failure, UserData>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.login(
        LoginParameter(email: email, password: password),
      );
      await localDataSource.cacheToLocal(user);
      return Right(user.toEntity());
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
  Future<void> removeFromLocal() async {
    await localDataSource.removeFromLocal();
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.removeFromLocal();
      return const Right(null);
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
  Future<Either<Failure, UserData>> signup(
    String username,
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.signup(
        SignupParameter(
          email: email,
          password: password,
          username: username,
        ),
      );
      await localDataSource.cacheToLocal(user);
      return Right(user.toEntity());
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
  Future<Either<Failure, UserData>> updateProfile(
    String username,
    String email,
    String password,
    String phoneNumber,
    File? profilePicture,
    bool deleteProfilePicture,
  ) async {
    try {
      final user = await remoteDataSource.updateProfile(
        UpdateProfileParameter(
          email: email,
          password: password,
          username: username,
          phoneNumber: phoneNumber,
          profilePicture: profilePicture,
          deleteProfilePicture: deleteProfilePicture,
        ),
      );
      await localDataSource.cacheToLocal(user);
      return Right(user.toEntity());
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
