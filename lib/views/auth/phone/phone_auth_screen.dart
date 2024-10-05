import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/views/auth/phone/phone_auth_controller.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_feild.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthScreen({super.key});
  final authController = Get.put(PhoneAuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Verify Your Phone Number',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              AppFeild(
                controller: authController.phoneAuthController,
                hintText: 'Enter your phone no',
              ),
              const SizedBox(height: 30),
              AppButton(
                text: 'Verify',
                onPressed: () {
                  authController.verifyPhoneNumber();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
