import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_box.dart';

import '../../../widgets/custom_appbar.dart';
import '../auth_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return AppBackground(
      isLight: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppString.forgetPassword,
          isDark: 'true',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppString.forgetPassword,
                          style: AppTextStyles.bodyStyle.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        2.vertical,
                        Text(
                          AppString.enterYourRegisteredEmail,
                          style: AppTextStyles.lightStyle
                              .copyWith(color: AppColors.greyColor),
                          textAlign: TextAlign.center,
                        ),
                        30.vertical,
                        CustomBox(
                          child: Column(
                            children: [
                              const AppFeild(
                                hintText: AppString.yourEmail,
                              ),
                              20.vertical,
                              controller.isLoading
                                  ? const SpinKitThreeBounce(
                                      color: AppColors.textColor,
                                      size: 25.0,
                                    )
                                  : AppButton(
                                      text: AppString.verify,
                                      onPressed: () {
                                        controller.resetPassword();
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.rememberThePassword,
                    style: AppTextStyles.lightStyle.copyWith(
                      color: AppColors.lightColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.goToLoginScreen(),
                    child: Text(
                      AppString.login,
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.mainColor,
                        fontFamily: AppFonts.sandBold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              30.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
