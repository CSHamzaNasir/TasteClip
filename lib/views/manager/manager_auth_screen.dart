import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/manager/manager_auth_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

class ManagerAuthScreen extends StatelessWidget {
  ManagerAuthScreen({super.key});
  final controller = Get.put(ManagerAuthController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        50.vertical,
                        Text(
                          AppString.createChannel,
                          style: AppTextStyles.headingStyle.copyWith(
                            color: AppColors.textColor,
                            height: 1.1,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        30.vertical,
                        Text(
                          AppString.createChannelDescription,
                          style: AppTextStyles.lightStyle.copyWith(
                            color: AppColors.mainColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        6.vertical,
                        Image.asset(
                          AppAssets.appLogo,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    AppButton(
                      btnRadius: 100,
                      text: AppString.registerChannel,
                      onPressed: controller.goToChannelRegisterScreen,
                    ),
                    16.vertical,
                    AppButton(
                      btnRadius: 100,
                      text: AppString.loginChannel,
                      onPressed: controller.goToChannelLogionScreen,
                    ),
                  ],
                ),
              ),
              16.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppString.channelFeatures,
                    style: AppTextStyles.bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppString.now,
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.popinsMedium,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              30.vertical
            ],
          ),
        ),
      ),
    );
  }
}
