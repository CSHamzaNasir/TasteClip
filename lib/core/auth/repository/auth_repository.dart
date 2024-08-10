import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasteclip/core/auth/repository/auth_base_repository.dart';
import 'package:tasteclip/models/user_model.dart';
import 'package:tasteclip/services/auth_service.dart';

class AuthRepository implements AuthBaseRepository {
  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;

  AuthRepository(
      {FirebaseAuth? firebaseAuth, FirestoreService? firestoreService})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestoreService = firestoreService ?? FirestoreService();

  @override
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String about,
    String address,
    String userImg,
  ) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(
          uid: user.uid,
          email: email,
          username: '',
          password: '',
        );
        log('Creating user: ${newUser.toMap()}');
        await _firestoreService.createUser(newUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('The email address is already in use.');
      } else {
        throw Exception('An error occurred: ${e.code}');
      }
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw Exception('Invalid email or password.');
      } else {
        throw Exception('An error occurred: ${e.code}');
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
