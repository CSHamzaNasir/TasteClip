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
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/detail/feedback_detail_screen.dart';
import 'package:tasteclip/utils/text_shimmer.dart' as shimmer_widgets;
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import 'watch_feedback_controller.dart';

class WatchFeedbackScreen extends StatelessWidget {
  WatchFeedbackScreen({super.key});
  final controller = Get.put(WatchFeedbackController());
  final userController = Get.put(UserController());
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
            child: shimmer_widgets.ProfileImageWithShimmer(
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
          if (controller.isLoading.value) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (controller.feedbacks.isEmpty) {
            return const Center(child: Text('No feedbacks found'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.feedbacks.length,
                    itemBuilder: (context, index) {
                      final feedback = controller.feedbacks[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => FeedbackDetailScreen(
                              feedback: feedback,
                              feedbackScope: FeedbackScope.allFeedback,
                            )),
                        child: FeedbackItem(
                          feedback: feedback,
                          feedbackScope: FeedbackScope.allFeedback,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      )),
    );
  }
}
