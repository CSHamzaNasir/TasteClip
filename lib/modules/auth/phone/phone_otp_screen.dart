import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/modules/auth/phone/phone_auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/custom_box.dart';

import '../../../widgets/app_feild.dart';
import '../../../widgets/custom_appbar.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final controller = Get.put(PhoneVerifyController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: true,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppString.otp,
          isDark: 'true',
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.enterYourOtp,
                  style: AppTextStyles.boldStyle.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                30.vertical,
                CustomBox(
                  child: Column(
                    children: [
                      AppFeild(
                        controller: controller.otpController,
                        hintText: AppString.enterYourOtp,
                      ),
                      12.vertical,
                      AppButton(
                        text: AppString.verify,
                        onPressed: () => controller.verifyOtp(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
