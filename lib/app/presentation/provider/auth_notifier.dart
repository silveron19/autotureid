import 'dart:io';

import 'package:autotureid/app/domain/entities/user_data.dart';
import 'package:autotureid/app/domain/repositories/auth_repository.dart';
import 'package:autotureid/core/utils/notifier_state.dart';
import 'package:flutter/material.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository});

  late UserData user;

  final NotifierState<UserData?> getUserFromLocalState = NotifierState();
  final NotifierState<UserData?> loginState = NotifierState();
  final NotifierState<UserData?> signupState = NotifierState();
  final NotifierState<UserData?> updateProfileState = NotifierState();
  final NotifierState<void> logoutState = NotifierState();

  void getUserFromLocal() {
    getUserFromLocalState.setLoading();
    notifyListeners();
    final userFromLocal = authRepository.getFromLocal();
    if (userFromLocal != null) {
      getUserFromLocalState.setSuccess();
      user = userFromLocal;
    } else {
      getUserFromLocalState.setError();
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    loginState.setLoading();
    notifyListeners();
    final result = await authRepository.login(email, password);
    result.fold(
      (failure) => loginState.setError(error: failure),
      (userData) {
        loginState.setSuccess(value: userData);
        user = userData;
      },
    );
    notifyListeners();
  }

  Future<void> signup(String username, String email, String password) async {
    signupState.setLoading();
    notifyListeners();
    final result = await authRepository.signup(username, email, password);
    result.fold(
      (failure) => signupState.setError(error: failure),
      (userData) {
        signupState.setSuccess(value: userData);
        user = userData;
      },
    );
    notifyListeners();
  }

  Future<void> updateProfile({
    String? username,
    String? email,
    String? password,
    String? phoneNumber,
    File? profilePicture,
  }) async {
    updateProfileState.setLoading();
    notifyListeners();
    final result = await authRepository.updateProfile(
      username,
      email,
      password,
      phoneNumber,
      profilePicture,
    );
    result.fold(
      (failure) => updateProfileState.setError(error: failure),
      (userData) {
        updateProfileState.setSuccess();
        user = userData;
      },
    );
    notifyListeners();
  }

  Future<void> logout() async {
    logoutState.setLoading();
    notifyListeners();
    final result = await authRepository.logout();
    result.fold(
      (failure) => logoutState.setError(error: failure),
      (_) => logoutState.setSuccess(),
    );
    notifyListeners();
  }
}
