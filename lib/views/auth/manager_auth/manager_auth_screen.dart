import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

class ManagerAuthScreen extends StatelessWidget {
  const ManagerAuthScreen({super.key});

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
                onPressed: () {},
              ),
              16.vertical,
              AppButton(
                text: AppString.login,
                btnRadius: 100,
                onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
