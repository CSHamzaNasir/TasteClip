// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/data/models/auth_models.dart';
import 'package:tasteclip/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.toNamed(AppRouter.userProfileScreen);
      return credential.user;
    } catch (e) {}
    return null;
  }

  @override
  Future<void> storeUserDataFirestore(AuthModel user) async {
    try {
      await _firestore.collection("email_user").doc(user.uid).set(user.toMap());
    } catch (e) {}
  }

  @override
  Future<User?> loginUserWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.toNamed(AppRouter.userProfileScreen);
      return credential.user;
    } catch (e) {}
    return null;
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential;
      }
    } catch (e) {}
    return null;
  }

  @override
  Future<AuthModel?> fetchCurrentUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection("email_user")
            .doc(currentUser.uid)
            .get();

        if (snapshot.exists) {
          return AuthModel.fromMap(snapshot.data()!);
        }
      }
    } catch (e) {}
    return null;
  }
}
