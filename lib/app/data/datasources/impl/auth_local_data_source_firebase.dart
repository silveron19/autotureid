import 'package:autotureid/app/data/datasources/abstracts/auth/auth_local_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FirebaseAuth firebaseAuth;
  // final SharedPreferences storage;

  AuthLocalDataSourceImpl({required this.firebaseAuth});

  // @override
  // Future<void> cacheToLocal(UserDataModel userData) async {
  //   await storage.setString('user', json.encode(userData.toJson()));
  // }

  @override
  String? getFromLocal() {
    return firebaseAuth.currentUser?.uid;
  }

  // @override
  // Future<void> removeFromLocal() async {
  //   await storage.remove('user');
  // }
}
