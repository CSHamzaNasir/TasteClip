import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/auth/user_auth/controllers/auth_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import 'package:tasteclip/widgets/custom_box.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
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
                              AppString.register,
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
                                  onTap: controller.goToLoginScreen,
                                  child: Text(
                                    AppString.login,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: AppFeild(
                                          controller:
                                              controller.fullNameController,
                                          hintText: AppString.fullName,
                                        ),
                                      ),
                                      4.horizontal,
                                      Expanded(
                                        child: AppFeild(
                                          controller:
                                              controller.userNameController,
                                          hintText: AppString.username,
                                        ),
                                      ),
                                    ],
                                  ),
                                  15.vertical,
                                  AppFeild(
                                      controller: controller.emailController,
                                      hintText: AppString.email),
                                  15.vertical,
                                  AppFeild(
                                    controller: controller.passwordController,
                                    hintText: AppString.password,
                                    isPasswordField: true,
                                  ),
                                  20.vertical,
                                  GetBuilder<AuthController>(builder: (_) {
                                    return controller.isLoading
                                        ? const SpinKitThreeBounce(
                                            color: AppColors.textColor,
                                            size: 25.0,
                                          )
                                        : AppButton(
                                            text: AppString.register,
                                            onPressed: controller.register,
                                          );
                                  })
                                ],
                              ),
                            ),
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
