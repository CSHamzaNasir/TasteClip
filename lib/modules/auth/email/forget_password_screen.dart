import 'package:flutter/material.dart';
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

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: true,
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
                        30.vertical,
                        Text(
                          AppString.forgetPassword,
                          style: AppTextStyles.mediumStyle.copyWith(
                            color: AppColors.lightColor,
                          ),
                        ),
                        2.vertical,
                        const Text(
                          AppString.enterYourRegisteredEmail,
                          style: AppTextStyles.thinStyle,
                          textAlign: TextAlign.center,
                        ),
                        20.vertical,
                        CustomBox(
                          child: Column(
                            children: [
                              const AppFeild(
                                hintText: AppString.yourEmail,
                              ),
                              20.vertical,
                              AppButton(
                                text: AppString.verify,
                                onPressed: () {},
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
                    style: AppTextStyles.thinStyle.copyWith(
                      color: AppColors.lightColor,
                    ),
                  ),
                  Text(
                    AppString.login,
                    style: AppTextStyles.thinStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.popinsBold,
                      decoration: TextDecoration.underline,
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
