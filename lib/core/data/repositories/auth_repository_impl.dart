// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';
import 'package:tasteclip/core/domain/repositories/auth_repository.dart';

import '../../../modules/bottombar/custom_bottom_bar.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.off(CustomBottomBar());
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
      Get.off(CustomBottomBar());
      return credential.user;
    } catch (e) {
      log("Login error: $e");
    }
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

  // @override
  // Future<UserCredential?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;

  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );

  //       final UserCredential userCredential =
  //           await _auth.signInWithCredential(credential);
  //       return userCredential;
  //     }
  //   } catch (e) {}
  //   return null;
  // }
}
