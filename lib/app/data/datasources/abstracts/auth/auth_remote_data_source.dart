import 'package:autotureid/app/data/models/user_data_model.dart';
import 'package:autotureid/core/parameter/auth_parameter.dart';

abstract class AuthRemoteDataSource {
  Future<UserDataModel> login(LoginParameter parameter);
  Future<UserDataModel> signup(SignupParameter parameter);
  Future<UserDataModel> updateProfile(UpdateProfileParameter parameter);
  Future<void> logout();

  Future<void> resetPassword(ResetPasswordParameter parameter);
}
