import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/manager_auth_model.dart';

abstract class ManagerAuthRepository {
  Future<User?> createManagerWithEmail(String businessEmail, String passkey);
  Future<void> storeManagerDataFirestore(ManagerAuthModel user);
  Future<ManagerAuthModel?> fetchCurrentManagerData();
}
