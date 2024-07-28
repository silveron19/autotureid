import 'package:autotureid/app/data/models/user_data_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToLocal(UserDataModel userData);
  UserDataModel? getFromLocal();
  Future<void> removeFromLocal();
}