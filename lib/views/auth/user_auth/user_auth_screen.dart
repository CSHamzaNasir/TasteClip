import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/views/auth/user_auth/user_auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import '../../../../widgets/or_continue_with.dart';
import '../../../widgets/social_button.dart';

class UserAuthScreen extends StatelessWidget {
  UserAuthScreen({super.key});
  final controller = Get.put(UserAuthController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      AppString.welcomeToTaste,
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
                      text: AppString.login,
                      onPressed: controller.goToLoginScreen,
                    ),
                    15.vertical,
                    AppButton(
                      text: AppString.register,
                      onPressed: controller.goToRegisterScreen,
                    ),
                    30.vertical,
                    const OrContinueWith(),
                    20.vertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SocialButton(
                          btnColor: AppColors.primaryColor,
                          foregroundClr: AppColors.whiteColor,
                          title: AppString.google,
                          icon: AppAssets.googleIcon,
                        ),
                        18.horizontal,
                        const SocialButton(
                          btnColor: AppColors.primaryColor,
                          foregroundClr: AppColors.whiteColor,
                          title: AppString.guest,
                          icon: AppAssets.guestIcon,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
