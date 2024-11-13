// ignore_for_file: empty_catches

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repositories/manager_auth_repository.dart';
import '../models/manager_auth_model.dart';

class ManagerRepositoryImpl implements ManagerAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<User?> createManagerWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      log("Error in createManagerWithEmail: $e");
      return null;
    }
  }

  @override
  Future<void> storeManagerDataFirestore(ManagerAuthModel user) async {
    try {
      await _firestore
          .collection("manager_credentials")
          .doc(user.uid)
          .set(user.toMap());
    } catch (e) {
      log("Error in storeManagerDataFirestore: $e");
    }
  }

  @override
  Future<ManagerAuthModel?> fetchCurrentManagerData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection("manager_credentials")
            .doc(currentUser.uid)
            .get();

        if (snapshot.exists) {
          return ManagerAuthModel.fromMap(snapshot.data()!);
        }
      }
    } catch (e) {}
    return null;
  }
}
