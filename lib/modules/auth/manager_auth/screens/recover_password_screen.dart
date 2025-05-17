import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/auth/user_auth/controllers/auth_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../utils/app_string.dart';

class RecoverPasswordScreen extends StatelessWidget {
  RecoverPasswordScreen({super.key});
  final controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
        isLight: false,
        child: Scaffold(
          appBar: CustomAppBar(
            onTap: () => controller.goToLoginScreen,
            title: AppString.recoverPassword,
            isDark: 'true',
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.forgetPassword,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
                16.vertical,
                Text(
                  AppString.weHaveSent,
                  style: AppTextStyles.lightStyle.copyWith(
                    color: AppColors.greyColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
