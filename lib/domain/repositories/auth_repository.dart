import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasteclip/data/models/auth_models.dart';

abstract class AuthRepository {
  Future<User?> createUserWithEmail(String email, String password);
  Future<void> storeUserDataFirestore(AuthModel user);
  Future<User?> loginUserWithEmail(String email, String password);
  Future<void> resetPassword(String email);
  Future<UserCredential?> signInWithGoogle();
  Future<AuthModel?> fetchCurrentUserData();
}
