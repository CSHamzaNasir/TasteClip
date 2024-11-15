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
          height: 300,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.lightColor, AppColors.whiteColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              AppButton(
                text: AppString.signup,
                onPressed: () {},
                btnRadius: 30,
              ),
              14.vertical,
              AppButton(
                text: AppString.signin,
                onPressed: () {},
                btnRadius: 30,
              ),
              14.vertical,
              TextButton.icon(
                onPressed: () {},
                label: Text(
                  AppString.continueWithGoogle,
                  style: AppTextStyles.lightStyle.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              const Spacer(),
            ],
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
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.appLogo,
                    width: 200,
                  ),
                  56.vertical,
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
                    onPressed: () {},
                    btnRadius: 30,
                  ),
                  10.vertical,
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      AppString.continueAsGuest,
                      style: AppTextStyles.lightStyle,
                    ),
                  ),
                  54.vertical,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
