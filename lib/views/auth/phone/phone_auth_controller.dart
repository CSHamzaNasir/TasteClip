import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/views/auth/phone/phone_otp_screen.dart';

class PhoneAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneAuthController = TextEditingController();
  final otpController = TextEditingController();

  String? verificationId;

  void verifyPhoneNumber() async {
    String phoneNumber = phoneAuthController.text.trim();
    if (phoneNumber.isEmpty || !phoneNumber.startsWith('+')) {
      log('Phone number is not in invalid format');
      return;
    }

    await _auth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException ex) {
        log('Phone number verification failed: ${ex.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        Get.to(() => OtpScreen());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: phoneNumber,
    );
  }

  void verifyOtp() async {
    try {
      if (verificationId == null) {
        log('verification id is null');
        return;
      }
      // ignore: unused_local_variable
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otpController.text.trim(),
      );

      Get.toNamed(AppRouter.roleScreen);
    } catch (e) {
      log('Error during OTP verification: $e');
    }
  }
}
