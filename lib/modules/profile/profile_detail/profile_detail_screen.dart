import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/profile/profile_detail/image_feedback/user_feedback_controller.dart';
import 'package:tasteclip/modules/profile/profile_detail/text_feedback/text_feedback_controller.dart';
import 'package:tasteclip/modules/profile/profile_detail/text_feedback/text_feedback_screen.dart';
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'image_feedback/user_feedback_screen.dart';

class ProfileDetailScreen extends StatelessWidget {
  ProfileDetailScreen({super.key});

  final controller = Get.put(UserProfileController());
  final imageFeedbackController =
      Get.put(UserFeedbackController(role: UserRole.user));
  final textFeedbackController =
      Get.put(TextFeedbackController(role: UserRole.user));

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            size: 18,
            color: AppColors.textColor,
          ),
          title: Text(
            controller.fullName.value,
            style: AppTextStyles.bodyStyle.copyWith(
              color: AppColors.textColor,
              fontFamily: AppFonts.sandMedium,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.vertical,
              Center(
                child: Obx(
                  () => Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: AppColors.primaryColor, width: 2)),
                    child: ProfileImageWithShimmer(
                      imageUrl: controller.profileImage.value,
                      radius: 75,
                    ),
                  ),
                ),
              ),
              32.vertical,
              Text(
                controller.fullName.value,
                style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.textColor, fontFamily: AppFonts.sandBold),
              ),
              Text(
                '@${controller.userName.value}',
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.textColor,
                  fontSize: 14,
                  fontFamily: AppFonts.sandSemiBold,
                ),
              ),
              16.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  controller.feedbackOptions.length,
                  (index) => GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Get.to(() => TextFeedbackScreen(
                              role: UserRole.user,
                            ))?.then((_) {
                          textFeedbackController.fetchFeedbackText();
                        });
                      }
                      if (index == 1 || index == 2) {
                        Get.to(() => UserFeedbackScreen(
                              role: UserRole.user,
                              feedbackCategory: index == 1
                                  ? FeedbackCategory.image
                                  : FeedbackCategory.video,
                            ));
                      }
                    },
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
                          GetBuilder<TextFeedbackController>(
                            builder: (controller) {
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${index == 0 ? textFeedbackController.textFeedbackCount.value : imageFeedbackController.imageFeedbackCount.value}',
                                      style: AppTextStyles.bodyStyle.copyWith(
                                        color: AppColors.mainColor,
                                        fontFamily: AppFonts.sandBold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " posts",
                                      style: AppTextStyles.bodyStyle.copyWith(
                                        color: AppColors.mainColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              16.vertical,
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.textColor.withCustomOpacity(0.1),
                              borderRadius: BorderRadius.circular(24)),
                          height: 30,
                          child: Obx(() => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    controller.categories.length, (index) {
                                  bool isSelected =
                                      controller.selectedIndex.value == index;
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.changeCategory(index),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: isSelected
                                            ? AppColors.mainColor
                                            : null,
                                      ),
                                      child: Text(
                                        controller.categories[index],
                                        style:
                                            AppTextStyles.regularStyle.copyWith(
                                          color: isSelected
                                              ? Colors.white
                                              : AppColors.textColor
                                                  .withCustomOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
