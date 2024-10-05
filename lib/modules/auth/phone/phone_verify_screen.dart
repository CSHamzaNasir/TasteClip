import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/auth/phone/phone_auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_text_styles.dart';
import '../../../constant/app_colors.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_feild.dart';
import '../../../widgets/custom_box.dart';
import '../../../widgets/or_continue_with.dart';
import '../../../widgets/social_button.dart';

class PhoneVerifyScreen extends StatelessWidget {
  PhoneVerifyScreen({super.key});
  final controller = Get.put(PhoneVerifyController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneVerifyController>(builder: (_) {
      return AppBackground(
        isDark: true,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: Get.height * .1),
                            Text(
                              AppString.verifyYourNumber,
                              style: AppTextStyles.boldStyle.copyWith(
                                color: AppColors.whiteColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            24.vertical,
                            CustomBox(
                              child: Column(
                                children: [
                                  const AppFeild(hintText: AppString.username),
                                  15.vertical,
                                  const AppFeild(
                                    hintText: AppString.phoneNumber,
                                  ),
                                  20.vertical,
                                  AppButton(
                                      text: AppString.verify, onPressed: () {})
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
                ),
                20.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SocialButton(
                      title: AppString.google,
                      icon: AppAssets.googleIcon,
                    ),
                    SocialButton(
                      onTap: controller.goToLoginScreen,
                      title: AppString.email,
                      icon: AppAssets.mailIcon,
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
