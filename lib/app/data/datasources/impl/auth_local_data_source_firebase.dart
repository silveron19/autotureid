import 'dart:convert';

import 'package:autotureid/app/data/datasources/abstracts/auth/auth_local_data_source.dart';
import 'package:autotureid/app/data/models/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences storage;

  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> cacheToLocal(UserDataModel userData) async {
    await storage.setString('user', json.encode(userData.toJson()));
  }

  @override
  UserDataModel? getFromLocal() {
    final user = storage.getString('user');
    if (user != null) {
      return UserDataModel.fromJson(json.decode(user));
    } else {
      return null;
    }
  }

  @override
  Future<void> removeFromLocal() async {
    await storage.remove('user');
  }
}
