import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/views/manager/manager_auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/constant/app_colors.dart';

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
                        const Text(
                          AppString.createChannel,
                          style: AppTextStyles.boldStyle,
                          textAlign: TextAlign.left,
                        ),
                        30.vertical,
                        const Text(
                          AppString.createChannelDescription,
                          style: AppTextStyles.lightStyle,
                          textAlign: TextAlign.left,
                        ),
                        6.vertical,
                        Image.asset(
                          AppAssets.appLogo,
                          width: 220,
                        ),
                        20.vertical,
                        AppButton(
                          text: AppString.registerChannel,
                          onPressed: () {},
                        ),
                        15.vertical,
                        AppButton(
                          text: AppString.loginChannel,
                          onPressed: () {},
                        ),
                        12.vertical,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              AppString.channelFeatures,
                              style: AppTextStyles.thinStyle,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              AppString.now,
                              style: AppTextStyles.thinStyle
                                  .copyWith(color: AppColors.mainColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        30.vertical
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
