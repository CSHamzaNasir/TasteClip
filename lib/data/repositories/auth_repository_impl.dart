// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      return credential.user;
    } catch (e) {}
    return null;
  }

  @override
  Future<void> storeUserDataFirestore(AuthModel user) async {
    try {
      _firestore.collection("email_user").doc(user.uid).set(user.toMap());
    } catch (e) {}
  }

  @override
  Future<User?> loginUserWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {}
    return null;
  }
}
