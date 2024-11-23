import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/auth/role/role_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../widgets/under_dev.dart';

class RoleScreen extends StatelessWidget {
  RoleScreen({super.key});
  final controller = Get.put(RoleController());
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.lightColor, AppColors.whiteColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                SvgPicture.asset(
                  AppAssets.welcome,
                  height: 200,
                ),
                30.vertical,
                AppButton(
                  text: AppString.signup,
                  onPressed: controller.goToRegisterScreen,
                  btnRadius: 30,
                ),
                14.vertical,
                AppButton(
                  text: AppString.signin,
                  onPressed: controller.goToLoginScreen,
                  btnRadius: 30,
                ),
                20.vertical,
                GestureDetector(
                  onTap: () => showUnderDevelopmentDialog(
                      context, "This feature is under development."),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppAssets.googleImg,
                        width: 20,
                        height: 20,
                      ),
                      4.horizontal,
                      Text(
                        AppString.continueWithGoogle,
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                30.vertical
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            30.vertical,
                            Image.asset(
                              AppAssets.appLogo,
                              width: double.infinity,
                              height: 250,
                            ),
                            56.vertical,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  AppString.getStartedAs,
                  style: AppTextStyles.boldBodyStyle
                      .copyWith(color: AppColors.textColor),
                ),
                30.vertical,
                AppButton(
                  text: AppString.user,
                  onPressed: () => _showBottomSheet(context),
                  btnRadius: 30,
                ),
                16.vertical,
                AppButton(
                  text: AppString.restaurantManager,
                  onPressed: () => controller.goToManagerAuthScreen(),
                  btnRadius: 30,
                ),
                10.vertical,
                TextButton(
                  onPressed: () => showUnderDevelopmentDialog(
                      context, "This feature is under development."),
                  child: Text(AppString.continueAsGuest,
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.mainColor,
                      )),
                ),
                30.vertical,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
