import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../config/app_text_styles.dart';
import '../../core/constant/app_colors.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final controller = Get.put(UserProfileController());
  final watchFeedbackController = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Scaffold(
              body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.vertical,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.mainColor)),
                    child: ProfileImageWithShimmer(
                      imageUrl: controller.profileImage.value,
                      radius: 65,
                    ),
                  ),
                  4.vertical,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.feedbackOptions
                      .map((option) => Column(
                            spacing: 6,
                            children: [
                              Text(
                                option['label'],
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: AppColors.mainColor,
                                  fontFamily: AppFonts.sandBold,
                                ),
                              ),
                              Text(
                                '31',
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
              Text(
                "Your Feedback",
                style: AppTextStyles.boldBodyStyle.copyWith(
                  color: AppColors.textColor,
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (watchFeedbackController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (watchFeedbackController.feedbacks.isEmpty) {
                    return const Center(child: Text('No feedbacks found'));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 10,
                      childAspectRatio: .8,
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: watchFeedbackController.feedbacks.length,
                    itemBuilder: (context, index) {
                      final feedback = watchFeedbackController.feedbacks[index];
                      return FeedbackItem(
                        feedback: feedback,
                        feedbackScope: FeedbackScope.currentUserFeedback,
                      );
                    },
                  );
                }),
              )
              // ProfileCard(
              //   onTap1: controller.goToSettingScreen,
              //   onTap: controller.goToProfileDetailScreen,
              //   controller: controller,
              //   title: AppString.profileDetails,
              //   subtitle: AppString.clickToSeeProfile,
              //   icon: AppAssets.profileReg,
              //   title1: AppString.setting,
              //   subtitle1: AppString.clickToSeeSetting,
              //   icon1: AppAssets.setting,
              // ),
              // InkWell(
              //   onTap: controller.goToEditProfileScreen,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(16),
              //         color: AppColors.textColor.withCustomOpacity(.1)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           "Edit profile",
              //           style: AppTextStyles.boldBodyStyle.copyWith(
              //             color: AppColors.mainColor,
              //             fontFamily: AppFonts.sandMedium,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          )),
        ),
      ),
    );
  }
}
