import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/manager/channel/channel_auth_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_box.dart';

class ChannelRegisterScreen extends StatelessWidget {
  ChannelRegisterScreen({super.key});
  final controller = Get.put(ChannelAuthController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: true,
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppString.register,
            isDark: "true",
          ),
          body: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppString.welcome,
                              style: AppTextStyles.headingStyle
                                  .copyWith(color: AppColors.lightColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppString.alreadyHaveAnAccount,
                                  style: AppTextStyles.bodyStyle
                                      .copyWith(color: AppColors.lightColor),
                                ),
                                5.horizontal,
                                GestureDetector(
                                  onTap: controller.goToChanelLoginScreen,
                                  child: Text(
                                    AppString.login,
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      fontFamily: AppFonts.popinsMedium,
                                      color: AppColors.whiteColor,
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
                                      hintText: AppString.resturentName),
                                  16.vertical,
                                  const AppFeild(hintText: AppString.address),
                                  16.vertical,
                                  const AppFeild(
                                      hintText: AppString.businessEmail),
                                  16.vertical,
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
                              ),
                            )
                          ],
                        ),
                      ),
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
