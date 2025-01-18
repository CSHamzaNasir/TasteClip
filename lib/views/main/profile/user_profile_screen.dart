import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/main/profile/user_profile_controller.dart';

import 'package:tasteclip/widgets/app_background.dart';

import '../../../config/app_text_styles.dart';
import '../../../constant/app_colors.dart';
import 'components/profile_card.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.userBgImg),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(180),
                    BlendMode.darken,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 2, color: AppColors.primaryColor)),
                        child: CircleAvatar(
                          backgroundColor: AppColors.mainColor,
                          radius: 30,
                          backgroundImage:
                              controller.profile_image.value.isNotEmpty
                                  ? NetworkImage(controller.profile_image.value)
                                  : null,
                          child: controller.profile_image.value.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 50,
                                )
                              : null,
                        ),
                      )),
                  12.vertical,
                  Obx(() => Text(
                        controller.fullName.isNotEmpty
                            ? controller.fullName.value
                            : "Loading...",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.whiteColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      )),
                  2.vertical,
                  Obx(() => Text(
                        controller.email.isNotEmpty
                            ? controller.email.value
                            : "Loading...",
                        style: AppTextStyles.bodyStyle.copyWith(
                            fontSize: 14,
                            color: AppColors.whiteColor.withAlpha(200)),
                      )),
                  12.vertical,
                ],
              ),
            ),
            16.vertical,
            ProfileCard(
              controller: controller,
              title: AppString.profileDetails,
              subtitle: AppString.clickToSeeProfile,
              icon: AppAssets.profileReg,
              title1: AppString.setting,
              subtitle1: AppString.clickToSeeSetting,
              icon1: AppAssets.setting,
            ),
            16.vertical,
            ProfileCard(
              controller: controller,
              title: AppString.theme,
              subtitle: AppString.clickTochangeTheme,
              icon: AppAssets.theme,
              title1: AppString.logout,
              subtitle1: AppString.clickTologout,
              icon1: AppAssets.logout,
            ),
          ],
        )),
      ),
    );
  }
}
