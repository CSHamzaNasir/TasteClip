import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/auth/role/role_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import '../../../widgets/or_continue_with.dart';

class RoleScreen extends StatelessWidget {
  RoleScreen({super.key});
  final controller = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      AppString.welcomeToTaste,
                      style: AppTextStyles.mediumStyle,
                      textAlign: TextAlign.center,
                    ),
                    40.vertical,
                    Image.asset(
                      AppAssets.appLogo,
                      width: 200,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppString.getStartedWith,
                        style: AppTextStyles.semiBoldStyle,
                      ),
                    ),
                    14.vertical,
                    AppButton(
                      text: AppString.user,
                      onPressed: controller.goToUserAuthSecreen,
                    ),
                    15.vertical,
                    AppButton(
                      text: AppString.guest,
                      onPressed: () {},
                    ),
                    30.vertical,
                    const OrContinueWith(),
                    20.vertical,
                    AppButton(
                      isGradient: false,
                      btnColor: AppColors.primaryColor,
                      text: AppString.restaurantManager,
                      onPressed: controller.goToManagerAuthSecreen,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
