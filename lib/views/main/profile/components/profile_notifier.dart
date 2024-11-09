import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/views/main/profile/user_profile_controller.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../constant/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../widgets/gradient_box.dart';

class ProfileNotifier extends StatelessWidget {
  const ProfileNotifier({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientBox(
      widthFactor: 1,
      heightFactor: 0.17,
      gradientColors: const [
        AppColors.primaryColor,
        AppColors.mainColor,
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<UserProfileController>(builder: (controller) {
              return GestureDetector(
                onTap: () => controller.goToProfileDetailsScreen(),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 20,
                      color: AppColors.lightColor,
                    ),
                    12.horizontal,
                    Text(
                      AppString.profileDetails,
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.lightColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
            2.vertical,
            Text(
              AppString.clickToSeeProfile,
              style: AppTextStyles.lightStyle.copyWith(
                color: AppColors.greyColor,
                fontFamily: AppFonts.popinsRegular,
              ),
            ),
            10.vertical,
            Row(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  size: 20,
                  color: AppColors.lightColor,
                ),
                12.horizontal,
                Text(
                  AppString.notifications,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
              ],
            ),
            2.vertical,
            Text(
              AppString.clickHereToSeeNotifications,
              style: AppTextStyles.lightStyle.copyWith(
                color: AppColors.greyColor,
                fontFamily: AppFonts.popinsRegular,
              ),
            )
          ],
        ),
      ),
    );
  }
}
