import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../widgets/app_feild.dart';
import 'phone_auth_controller.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final controller = Get.put(PhoneAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppFeild(
              controller: controller.otpController,
              hintText: 'Enter your OTP',
            ),
            const SizedBox(height: 12),
            AppButton(
              text: 'Send',
              onPressed: () {
                controller.verifyOtp();
              },
            ),
          ],
        ),
      ),
    );
  }
}
