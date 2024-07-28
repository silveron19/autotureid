import 'package:autotureid/app/data/datasources/abstracts/auth/auth_local_data_source.dart';
import 'package:autotureid/app/data/datasources/abstracts/auth/auth_remote_data_source.dart';
import 'package:autotureid/app/data/datasources/firebase/auth_remote_data_source_firebase.dart';
import 'package:autotureid/app/data/datasources/impl/auth_local_data_source_firebase.dart';
import 'package:autotureid/app/data/repositories/auth_repository_impl.dart';
import 'package:autotureid/app/domain/repositories/auth_repository.dart';
import 'package:autotureid/app/presentation/provider/auth_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceFirebase(
      firebaseAuth: sl(),
      firestore: sl(),
      firebaseStorage: sl(),
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      storage: sl(),
    ),
  );

  // Provider
  sl.registerFactory(
    () => AuthNotifier(
      authRepository: sl(),
    ),
  );

  // External
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}