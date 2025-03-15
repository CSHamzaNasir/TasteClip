import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/modules/auth/manager_auth/manager_auth_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

class ManagerAuthScreen extends StatelessWidget {
  ManagerAuthScreen({super.key});
  final controller = Get.put(ManagerAuthController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      50.vertical,
                      Text(
                        AppString.createChannel,
                        style: AppTextStyles.headingStyle.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      30.vertical,
                      Text(
                        AppString.createChannelDescription,
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                      Image.asset(
                        AppAssets.appLogo,
                        width: 220,
                      )
                    ],
                  ),
                ),
              ),
              AppButton(
                text: AppString.register,
                btnRadius: 100,
                onPressed: () => controller.goToRegisterScreen(),
              ),
              16.vertical,
              AppButton(
                text: AppString.login,
                btnRadius: 100,
                onPressed: () => controller.goToLoginScreen(),
              ),
              16.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppString.channelFeatures,
                    style: AppTextStyles.bodyStyle,
                  ),
                  Text(AppString.now,
                      style: AppTextStyles.boldBodyStyle
                          .copyWith(color: AppColors.mainColor))
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
