import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/auth/phone/phone_verify_controller.dart';

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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * .1),
                          Text(
                            'Verify Your Number',
                            style: AppTextStyles.boldStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          24.vertical,
                          CustomBox(
                            child: Column(
                              children: [
                                const AppFeild(hintText: 'Username'),
                                15.vertical,
                                const AppFeild(
                                  hintText: 'Phone Number',
                                ),
                                20.vertical,
                                AppButton(text: 'Verify', onPressed: () {})
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(
                      title: 'Google',
                      icon: AppAssets.googleIcon,
                    ),
                    SocialButton(
                      title: 'Email',
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
