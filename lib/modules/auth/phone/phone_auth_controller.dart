import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/modules/auth/phone/phone_otp_screen.dart';

class PhoneVerifyController extends GetxController {
  final phoneAuthController = TextEditingController();
  final otpController = TextEditingController();

  var verificationId = ''.obs;

  Future<void> verifyPhoneNumber() async {
    String phoneNumber = phoneAuthController.text.trim();
    if (phoneNumber.isEmpty || !phoneNumber.startsWith('+')) {
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException ex) {
        log('Phone number verification failed: ${ex.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId.value = verificationId;
        Get.to(() => OtpScreen());
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: phoneNumber,
    );
  }

  Future<void> verifyOtp() async {
    if (verificationId.value.isEmpty) {
      return;
    }

    try {
      // ignore: unused_local_variable
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otpController.text.trim(),
      );
      Get.toNamed('/userScreen');
    } catch (e) {
      log('Error during OTP verification: $e');
    }
  }

  void goToLoginScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
