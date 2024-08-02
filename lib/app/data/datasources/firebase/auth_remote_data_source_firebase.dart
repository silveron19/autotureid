import 'package:autotureid/app/data/datasources/abstracts/auth/auth_remote_data_source.dart';
import 'package:autotureid/app/data/models/user_data_model.dart';
import 'package:autotureid/app/data/models/user_plan_model.dart';
import 'package:autotureid/core/custom_exception.dart';
import 'package:autotureid/core/parameter/auth_parameter.dart';
import 'package:autotureid/core/utils/firebase_message_parse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRemoteDataSourceFirebase implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final FirebaseStorage firebaseStorage;

  AuthRemoteDataSourceFirebase({
    required this.firebaseAuth,
    required this.firestore,
    required this.firebaseStorage,
  });

  @override
  Future<UserDataModel> login(LoginParameter parameter) async {
    late UserCredential userCredential;
    // log in with email and password
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: parameter.email,
        password: parameter.password,
      );
    } on FirebaseAuthException catch (e) {
      throw CustomException(FirebaseMessageParse.parseSignInError(e.code));
    }

    // get user data from firestore
    final userDoc = await firestore.collection('users').doc(userCredential.user!.uid).get();

    return UserDataModel.fromJson(userDoc.data()!);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserDataModel> signup(SignupParameter parameter) async {
    late UserCredential userCredential;
    // sign up with email and password
    try {
      userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: parameter.email,
        password: parameter.password,
      );
    } on FirebaseAuthException catch (e) {
      throw CustomException(FirebaseMessageParse.parseSignUpError(e.code));
    }

    late UserDataModel userData;

    // create user plan data in firestore with transaction
    await firestore.runTransaction((transaction) async {
      final userDoc = firestore.collection('users').doc(userCredential.user!.uid);

      userData = UserDataModel(
        id: userCredential.user!.uid,
        username: parameter.username,
        email: parameter.email,
      );

      // create user data model
      transaction.set(userDoc, userData.toJson());

      final userPlanDocRef = firestore.collection('user_plans').doc();

      // get plan data from firestore where type is basic
      final planDoc = await firestore.collection('plans').where('type', isEqualTo: 'basic').get();

      final planData = planDoc.docs.first.data();

      final userPlan = UserPlanModel(
        id: userPlanDocRef.id,
        userId: userData.id,
        planId: planData['id'],
        startDate: null,
        endDate: null,
        renewalDate: null,
        status: 'active',
      );

      // create user plan data model
      transaction.set(userPlanDocRef, userPlan.toJson());
    });

    // create user data model

    return userData;
  }

  @override
  Future<UserDataModel> updateProfile(UpdateProfileParameter parameter) async {
    // check if user update email
    if (parameter.email != firebaseAuth.currentUser!.email) {
      // update email in firebase auth
      try {
        await firebaseAuth.currentUser!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: firebaseAuth.currentUser!.email!,
            password: parameter.password,
          ),
        );
        await firebaseAuth.currentUser!.updateEmail(parameter.email);
        // await firebaseAuth.currentUser!.verifyBeforeUpdateEmail(parameter.email!);
      } on FirebaseAuthException catch (e) {
        throw CustomException(FirebaseMessageParse.parseUpdateEmailError(e.code));
      }
    }

    // update user data in firestore
    final userDoc = firestore.collection('users').doc(firebaseAuth.currentUser!.uid);

    // user data model
    final doc = await userDoc.get();

    final oldUserData = UserDataModel.fromJson(doc.data()!);

    // update profile picture
    String? newProfilePictureUrl;
    if (parameter.profilePicture != null) {
      if (oldUserData.profilePicture != null) {
        // delete old profile picture
        final oldProfilePictureRef =
            firebaseStorage.ref().child('profile_pictures/${firebaseAuth.currentUser!.uid}');
        await oldProfilePictureRef.delete();
      }
      // upload profile picture and get download url
      final ref = firebaseStorage.ref().child('profile_pictures/${firebaseAuth.currentUser!.uid}');
      final uploadTask = ref.putFile(parameter.profilePicture!);
      await uploadTask.whenComplete(() => null);
      newProfilePictureUrl = await ref.getDownloadURL();
    }

    // if delete profile picture
    if (parameter.deleteProfilePicture) {
      if (oldUserData.profilePicture != null) {
        // delete old profile picture
        final oldProfilePictureRef =
            firebaseStorage.ref().child('profile_pictures/${firebaseAuth.currentUser!.uid}');
        await oldProfilePictureRef.delete();
        newProfilePictureUrl = null;
      }
    }

    final newUserData = UserDataModel(
      id: oldUserData.id,
      username: parameter.username.isNotEmpty ? parameter.username : oldUserData.username,
      email: parameter.email.isNotEmpty ? parameter.email : oldUserData.email,
      phoneNumber:
          parameter.phoneNumber.isNotEmpty ? parameter.phoneNumber : oldUserData.phoneNumber,
      profilePicture: newProfilePictureUrl ?? oldUserData.profilePicture,
    );

    // update user data model
    await userDoc.update(newUserData.toJson());

    return newUserData;
  }

  @override
  Future<void> resetPassword(ResetPasswordParameter parameter) async {
    try {
      final userEmail = parameter.email ?? firebaseAuth.currentUser!.email!;

      await firebaseAuth.sendPasswordResetEmail(email: userEmail);
    } on FirebaseAuthException catch (e) {
      throw CustomException(FirebaseMessageParse.parseForgotPasswordError(e.code));
    }
  }
}
