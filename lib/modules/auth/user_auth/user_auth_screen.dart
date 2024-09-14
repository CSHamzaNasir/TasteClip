import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/modules/auth/user_auth/user_auth_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../../widgets/or_continue_with.dart';

class UserAuthScreen extends StatelessWidget {
  UserAuthScreen({super.key});
  final controller = Get.put(UserAuthController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              60.vertical,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to\nTaste Clip',
                          style: AppTextStyles.mediumStyle,
                          textAlign: TextAlign.center,
                        ),
                        40.vertical,
                        Image.asset(
                          AppAssets.appLogo,
                          width: 200,
                        ),
                        14.vertical,
                        AppButton(
                          text: 'Login',
                          onPressed: controller.goToLoginScreen,
                        ),
                        15.vertical,
                        AppButton(
                          text: 'Register',
                          onPressed: controller.goToRegisterScreen,
                        ),
                        30.vertical,
                        const OrContinueWith(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        isGradient: false,
                        btnColor: AppColors.primaryColor,
                        text: 'Google',
                        onPressed: () {},
                      ),
                    ),
                    18.horizontal,
                    Expanded(
                      child: AppButton(
                        icon: Icons.phone,
                        isGradient: false,
                        btnColor: AppColors.primaryColor,
                        text: 'Phone',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              30.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
