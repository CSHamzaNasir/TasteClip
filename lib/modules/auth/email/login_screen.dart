import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/auth/auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_box.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return AppBackground(
        isLight: false,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppString.login,
                              style: AppTextStyles.headingStyle.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                            10.horizontal,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppString.dontHaveAnAccount,
                                  style: AppTextStyles.bodyStyle.copyWith(
                                    color: AppColors.lightColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.goToRegisterScreen,
                                  child: Text(
                                    AppString.register,
                                    style: AppTextStyles.boldBodyStyle.copyWith(
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
                                  AppFeild(
                                    hintText: AppString.email,
                                    controller: controller.emailController,
                                  ),
                                  15.vertical,
                                  AppFeild(
                                    hintText: AppString.password,
                                    isPasswordField: true,
                                    controller: controller.passwordController,
                                  ),
                                  20.vertical,
                                  controller.isLoading
                                      ? const SpinKitThreeBounce(
                                          color: AppColors.textColor,
                                          size: 25.0,
                                        )
                                      : AppButton(
                                          text: AppString.login,
                                          onPressed: controller.login,
                                        ),
                                  10.vertical,
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.goToForgetPasswordScreen(),
                                      child: Text(
                                        AppString.forgetPassword,
                                        style: AppTextStyles.bodyStyle.copyWith(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            30.vertical,
                          ],
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
    });
  }
}
