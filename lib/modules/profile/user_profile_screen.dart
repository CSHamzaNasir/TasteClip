import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/role/role_screen.dart';
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../config/app_text_styles.dart';
import '../../core/constant/app_colors.dart';
import 'components/profile_card.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Scaffold(
              body: Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              12.vertical,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ProfileImageWithShimmer(
                    imageUrl: controller.profileImage.value,
                    radius: 75,
                  ),
                  Text(
                    controller.fullName.isNotEmpty
                        ? controller.fullName.value
                        : "Loading...",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  2.vertical,
                  Text(
                    controller.email.isNotEmpty
                        ? controller.email.value
                        : "Loading...",
                    style: AppTextStyles.bodyStyle.copyWith(
                        fontSize: 14,
                        color: AppColors.textColor.withAlpha(200)),
                  ),
                ],
              ),
              ProfileCard(
                onTap: controller.goToProfileDetailScreen,
                controller: controller,
                title: AppString.profileDetails,
                subtitle: AppString.clickToSeeProfile,
                icon: AppAssets.profileReg,
                title1: AppString.setting,
                subtitle1: AppString.clickToSeeSetting,
                icon1: AppAssets.setting,
              ),
              ProfileCard(
                onTap1: controller.logout,
                onTap: () => Get.to((RoleScreen())),
                controller: controller,
                title: AppString.theme,
                subtitle: AppString.clickTochangeTheme,
                icon: AppAssets.setting,
                title1: AppString.logout,
                subtitle1: AppString.clickTologout,
                icon1: AppAssets.logout,
              ),
              InkWell(
                onTap: controller.goToEditProfileScreen,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.textColor.withCustomOpacity(.1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Edit profile",
                        style: AppTextStyles.boldBodyStyle.copyWith(
                          color: AppColors.mainColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
