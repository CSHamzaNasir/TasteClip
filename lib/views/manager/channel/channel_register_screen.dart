import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/manager/manager_auth_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_box.dart';

class ChannelRegisterScreen extends StatelessWidget {
  ChannelRegisterScreen({super.key});
  final controller = Get.put(ManagerAuthController());

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
                                  onTap: controller.goToChannelLogionScreen,
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
                                  AppFeild(
                                      controller:
                                          controller.restaurantNameController,
                                      hintText: AppString.resturentName),
                                  16.vertical,
                                  AppFeild(
                                    controller: controller.addressController,
                                    hintText: AppString.address,
                                  ),
                                  16.vertical,
                                  AppFeild(
                                      controller:
                                          controller.businessEmailController,
                                      hintText: AppString.businessEmail),
                                  16.vertical,
                                  AppFeild(
                                    controller: controller.passkeyController,
                                    hintText: AppString.passkey,
                                    isPasswordField: true,
                                  ),
                                  30.vertical,
                                  GetBuilder<ManagerAuthController>(
                                      builder: (_) {
                                    return controller.isLoading
                                        ? const SpinKitThreeBounce(
                                            color: AppColors.textColor,
                                            size: 25.0,
                                          )
                                        : AppButton(
                                            text: AppString.submit,
                                            onPressed: controller.register,
                                          );
                                  })
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
