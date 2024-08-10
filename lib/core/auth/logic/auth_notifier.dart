// ignore_for_file: use_build_context_synchronously

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/core/auth/repository/auth_repository.dart';
import 'package:tasteclip/models/user_model.dart';
import 'package:tasteclip/network/api_response.dart';

class AuthNotifier extends StateNotifier<ApiResponse<UserModel?>> {
  AuthNotifier() : super(ApiResponse.idle("Initial State"));
  final AuthRepository authRepository = AuthRepository();

  void updateState(ApiResponse<UserModel?> newState) => state = newState;

  void reset() {
    updateState(ApiResponse.idle("Initial State"));
  }

  Object get appUser => state.data ?? [];

  Future<void> signUp(
    BuildContext context,
    final String email,
    final String password,
    final String name,
    final String about,
    final String address,
    final String userImg,
  ) async {
    updateState(ApiResponse.loading('Creating user profile...'));
    try {
      await authRepository.signUpWithEmailAndPassword(
          email, password, name, about, address, userImg);
      AppRouter.push(AppRouter.firstScreen);
    } on Exception catch (e) {
      String errorMessage;
      if (e.toString().contains('email-already-in-use')) {
        errorMessage = 'The email address is already in use.';
      } else if (e.toString().contains('network-request-failed')) {
        errorMessage = 'Please connect to the internet.';
      } else if (e.toString().contains('invalid-email') ||
          e.toString().contains('empty')) {
        errorMessage = 'Please fill all fields.';
      } else {
        errorMessage = 'Failed to signup:\n$e';
      }
      DelightToastBar(
        builder: (context) => ToastCard(
          leading: const Icon(
            Icons.error,
            size: 28,
            color: Colors.red,
          ),
          title: Text(
            errorMessage,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ),
      ).show(context);
      updateState(ApiResponse.error(errorMessage));
    }
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    updateState(ApiResponse.loading('Signing in...'));
    try {
      await authRepository.signInWithEmailAndPassword(email, password);
      AppRouter.push(AppRouter.firstScreen);
    } on Exception catch (e) {
      String errorMessage;
      if (e.toString().contains('user-not-found') ||
          e.toString().contains('wrong-password')) {
        errorMessage = 'Invalid email or password.';
      } else if (e.toString().contains('network-request-failed')) {
        errorMessage = 'Please connect to the internet.';
      } else if (e.toString().contains('empty')) {
        errorMessage = 'Please fill all fields.';
      } else {
        errorMessage = 'Failed to sign in:\n$e';
      }
      DelightToastBar(
        builder: (context) => ToastCard(
          leading: const Icon(
            Icons.error,
            size: 28,
            color: Colors.red,
          ),
          title: Text(
            errorMessage,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ),
      ).show(context);
      updateState(ApiResponse.error(errorMessage));
    }
  }

  void signOut() async {
    await authRepository.signOut();
    AppRouter.push(AppRouter.login);
  }
}
