import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasteclip/core/auth/logic/auth_notifier.dart';
import 'package:tasteclip/models/user_model.dart';
import 'package:tasteclip/network/api_response.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, ApiResponse<UserModel?>>(
  (ref) => AuthNotifier(),
);
