import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/explore/components/top_filter.dart';
import 'package:tasteclip/modules/explore/video_feedback_display.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import 'components/bottom_filter.dart';
import 'components/image_feedback_display.dart' show ImageFeedbackDisplay;
import 'components/text_feedback_display.dart';
import 'watch_feedback_controller.dart';

class WatchFeedbackScreen extends StatelessWidget {
  WatchFeedbackScreen({super.key});
  final controller = Get.put(WatchFeedbackController());
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 12),
                child: SvgPicture.asset(AppAssets.vertMore),
              )
            ],
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ProfileImageWithShimmer(
                  imageUrl: userController.userProfileImage.value),
            ),
            centerTitle: true,
            title: Text("Explore Feedback",
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.textColor,
                  fontFamily: AppFonts.sandBold,
                )),
            backgroundColor: AppColors.transparent,
            elevation: 0,
          ),
          body: Obx(() {
            return Stack(
              children: [
                Padding(
                  padding: controller.selectedIndex.value == 2
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16),
                  child: Column(
                    children: [
                      Visibility(
                        visible: controller.selectedIndex.value != 2,
                        child: Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: AppFeild(
                                feildClr: AppColors.whiteColor,
                                feildSideClr: false,
                                radius: 50,
                                hintText: "hintText",
                                prefixImage: AppAssets.search,
                                isSearchField: true,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: AppColors.btnUnSelectColor
                                          .withCustomOpacity(.5))),
                              child: SvgPicture.asset(
                                AppAssets.menuIcon,
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.vertical,
                      Visibility(
                        visible: controller.selectedIndex.value != 2,
                        child: TopFilter(controller: controller),
                      ),
                      if (controller.feedbackList.isEmpty)
                        Center(child: CupertinoActivityIndicator())
                      else
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: controller.selectedIndex.value == 0
                                    ? TextFeedbackDisplay( 
                                        category: FeedbackCategory.text,
                                        feedback: FeedbackScope.allFeedback,
                                      )
                                    : controller.selectedIndex.value == 1
                                        ? ImageFeedbackDisplay(
                                            feedback:
                                                FeedbackScope.branchFeedback,
                                            category: FeedbackCategory.image,
                                          )
                                        : VideoFeedbackDisplay(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomFilter(controller: controller),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
