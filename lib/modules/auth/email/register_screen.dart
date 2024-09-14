import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/email/register_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_box.dart';
import 'package:tasteclip/widgets/or_continue_with.dart';

import '../../../widgets/social_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final controller = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (_) {
      return AppBackground(
        isDark: true,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * .1),
                          Text(
                            'Register',
                            style: AppTextStyles.boldStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          10.horizontal,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: AppTextStyles.thinStyle.copyWith(
                                    color: AppColors.lightColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.goToLoginScreen,
                                  child: Text(
                                    'Login',
                                    style: AppTextStyles.thinStyle.copyWith(
                                      color: AppColors.lightColor,
                                      fontFamily: AppFonts.popinsBold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ]),
                          20.vertical,
                          CustomBox(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: AppFeild(
                                        hintText: 'Full Name',
                                      ),
                                    ),
                                    4.horizontal,
                                    const Expanded(
                                      child: AppFeild(
                                        hintText: 'Username',
                                      ),
                                    ),
                                  ],
                                ),
                                15.vertical,
                                const AppFeild(hintText: 'Email'),
                                15.vertical,
                                const AppFeild(
                                  hintText: 'Password',
                                  isPasswordField: true,
                                ),
                                20.vertical,
                                AppButton(text: 'Register', onPressed: () {})
                              ],
                            ),
                          ),
                          30.vertical,
                          const OrContinueWith(
                            isDarkMode: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                20.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SocialButton(
                      title: 'Google',
                      icon: AppAssets.googleIcon,
                    ),
                    SocialButton(
                      onTap: controller.goToPhoneVerifyScreen,
                      title: 'Phone',
                      icon: AppAssets.phoneIcon,
                    )
                  ],
                ),
                30.vertical,
              ],
            ),
          ),
        ),
      );
    });
  }
}
