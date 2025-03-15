import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';

abstract class AuthRepository {
  Future<User?> createUserWithEmail(String email, String password);
  Future<void> storeUserDataFirestore(AuthModel user);
  Future<User?> loginUserWithEmail(String email, String password);
  Future<void> resetPassword(String email);
}
