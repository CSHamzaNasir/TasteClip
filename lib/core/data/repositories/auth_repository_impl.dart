import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';
import 'package:tasteclip/core/domain/repositories/auth_repository.dart';
import 'package:tasteclip/modules/bottombar/custom_bottom_bar.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; 
  @override
  Future<void> updateProfileImage(String uid, String imageUrl) async {
    try {
      await _firestore
          .collection("email_user")
          .doc(uid)
          .update({'profileImage': imageUrl});
    } catch (e) {
      log("Update profile image error: $e");
      rethrow;
    }
  }

  @override
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.off(() => CustomBottomBar());
      return credential.user;
    } catch (e) {
      log("message");
    }
    return null;
  }

  @override
  Future<void> storeUserDataFirestore(AuthModel user) async {
    try {
      await _firestore.collection("email_user").doc(user.uid).set(user.toMap());
    } catch (e) {
      log("message");
    }
  }

  @override
  Future<User?> loginUserWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.off(() => CustomBottomBar());
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
}
