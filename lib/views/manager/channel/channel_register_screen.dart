import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/views/manager/channel/channel_auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_box.dart';

class ChannelRegisterScreen extends StatelessWidget {
  ChannelRegisterScreen({super.key});
  final controller = Get.put(ChannelAuthController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  50.vertical,
                  Text(
                    AppString.welcome,
                    style: AppTextStyles.boldStyle
                        .copyWith(color: AppColors.lightColor),
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
                        onTap: controller.goToChanelLoginScreen,
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
                      Image.asset(AppAssets.resturentLogo),
                      6.vertical,
                      const Text(AppString.uploadLogo),
                      7.vertical,
                      const AppFeild(hintText: AppString.resturentName),
                      15.vertical,
                      const AppFeild(hintText: AppString.address),
                      15.vertical,
                      const AppFeild(hintText: AppString.businessEmail),
                      15.vertical,
                      const AppFeild(
                        hintText: AppString.passkey,
                        isPasswordField: true,
                      ),
                      30.vertical,
                      AppButton(
                        text: 'Submit',
                        onPressed: () {},
                      )
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
