import 'dart:io';

import 'package:autotureid/app/domain/entities/user_data.dart';
import 'package:autotureid/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserData>> login(
    String email,
    String password,
  );

  Future<Either<Failure, UserData>> signup(
    String username,
    String email,
    String password,
  );

  Future<Either<Failure, UserData>> updateProfile(
    String username,
    String email,
    String password,
    String phoneNumber,
    File? profilePicture,
    bool deleteProfilePicture,
  );

  Future<Either<Failure, void>> resetPassword(String? email);

  Future<Either<Failure, void>> logout();

  Future<void> cacheToLocal(UserData userData);
  UserData? getFromLocal();
  Future<void> removeFromLocal();
}
