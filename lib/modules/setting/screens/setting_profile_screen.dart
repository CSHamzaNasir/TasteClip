import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/splash/controller/local_user_controller.dart';
import 'package:tasteclip/modules/setting/controllers/setting_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

class SettingProfileScreen extends StatelessWidget {
  SettingProfileScreen({super.key});
  final settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              size: 18,
              Icons.arrow_back_ios,
            ),
            color: AppColors.textColor,
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: Text(
            "Security",
            style: AppTextStyles.bodyStyle.copyWith(
              color: AppColors.textColor,
              fontFamily: AppFonts.sandBold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
          child: Column(
            spacing: 32,
            children: [
              Row(
                children: [
                  Text(
                    "Email",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    UserController.to.userEmail.value,
                    style: AppTextStyles.lightStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Full Name",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    UserController.to.userName.value,
                    style: AppTextStyles.lightStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
