import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/modules/manager/auth/channel_auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_box.dart';

class ChannelLoginScreen extends StatelessWidget {
  ChannelLoginScreen({super.key});
  final controller = Get.put(ChannelAuthController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                AppString.welcomeBack,
                style: AppTextStyles.boldStyle.copyWith(
                  color: AppColors.lightColor,
                ),
              ),
              10.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.alreadyHaveAnAccount,
                    style: AppTextStyles.thinStyle
                        .copyWith(color: AppColors.lightColor),
                  ),
                  5.horizontal,
                  GestureDetector(
                    onTap: controller.goToChanelRegisterScreen,
                    child: Text(
                      AppString.login,
                      style: AppTextStyles.thinStyle.copyWith(
                        color: AppColors.lightColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              20.vertical,
              CustomBox(
                child: Column(
                  children: [
                    const AppFeild(
                      hintText: AppString.businessEmail,
                    ),
                    15.vertical,
                    const AppFeild(
                      hintText: AppString.passkey,
                      isPasswordField: true,
                    ),
                    20.vertical,
                    AppButton(
                      text: AppString.login,
                      onPressed: () {},
                    ),
                    10.vertical,
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        AppString.forgetpasskey,
                        style: AppTextStyles.thinStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
