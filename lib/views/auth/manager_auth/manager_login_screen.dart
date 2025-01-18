import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/auth/manager_auth/manager_auth_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';
import 'package:tasteclip/widgets/custom_box.dart';

class ManagerLoginScreen extends StatelessWidget {
  ManagerLoginScreen({super.key});
  final controller = Get.put(ManagerAuthController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: true,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppString.login,
          isDark: "true",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.welcomeBack,
                style: AppTextStyles.headingStyle.copyWith(
                  color: AppColors.lightColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.dontHaveAnAccount,
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.lightColor,
                    ),
                  ),
                  3.horizontal,
                  Text(
                    AppString.login,
                    style: AppTextStyles.boldBodyStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
              24.vertical,
              CustomBox(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      AppFeild(
                        controller: controller.businessEmailController,
                        hintText: AppString.businessEmail,
                      ),
                      16.vertical,
                      AppFeild(
                        controller: controller.passkeyController,
                        hintText: AppString.passkey,
                      ),
                      20.vertical,
                      AppButton(
                        text: AppString.submit,
                        onPressed: () {
                          controller.loginManager();
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
