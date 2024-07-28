import 'dart:io';

class LoginParameter {
  final String email;
  final String password;

  LoginParameter({required this.email, required this.password});
}

class SignupParameter {
  final String username;
  final String email;
  final String password;

  SignupParameter({
    required this.email,
    required this.password,
    required this.username,
  });
}

class UpdateProfileParameter {
  final String? username;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final File? profilePicture;

  UpdateProfileParameter({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneNumber,
    required this.profilePicture,
  });
}