import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/views/main/profile/user_profile_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

class ProfileDetailScreen extends StatelessWidget {
  ProfileDetailScreen({
    super.key,
  });
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.vertical,
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                    ),
                    16.horizontal,
                    Text(AppString.profileDetails,
                        style: AppTextStyles.bodyStyle.copyWith(
                            color: AppColors.textColor,
                            fontFamily: AppFonts.sandSemiBold))
                  ],
                ),
                16.vertical,
                Center(
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: AppColors.primaryColor, width: 2)),
                      child: CircleAvatar(
                        radius: 75,
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
                    ),
                  ),
                ),
                32.vertical,
                Obx(
                  () => Text(
                    controller.fullName.value,
                    style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.sandBold),
                  ),
                ),
                Obx(
                  () => Text(
                    '@${controller.userName.value}',
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                ),
                16.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    controller.feedbackOptions.length,
                    (index) => GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.greyColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              controller.feedbackOptions[index]['icon'],
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(height: 12),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '12 ',
                                    style: AppTextStyles.bodyStyle.copyWith(
                                        color: AppColors.mainColor,
                                        fontFamily: AppFonts.sandBold),
                                  ),
                                  TextSpan(
                                    text: "posts",
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
