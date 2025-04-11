import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/modules/explore/components/image_feedback_card.dart';
import 'package:tasteclip/modules/explore/detail/feedback_detail_screen.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../widgets/app_background.dart';

class UserFeedbackScreen extends StatelessWidget {
  final UserRole role;
  final FeedbackScope? feedbackScope;

  UserFeedbackScreen({
    super.key,
    required this.role,
    this.feedbackScope,
  });

  final controller = Get.put(WatchFeedbackController());
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: Obx(() {
          if (controller.feedbackList.isEmpty) {
            return Center(child: CupertinoActivityIndicator());
          }
          return Column(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                    color: AppColors.mainColor),
                child: Center(
                  child: Text("Image Feedback",
                      style: AppTextStyles.boldBodyStyle
                          .copyWith(color: AppColors.lightColor)),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: controller.feedbackList.length,
                  itemBuilder: (context, index) {
                    var feedback = controller.feedbackList[index];
                    return InkWell(
                      onTap: () => Get.to(
                          () => FeedbackDetailScreen(feedback: feedback)),
                      child: ImageFeedbackCard(
                        feedback: feedback,
                        feedbackScope: FeedbackScope.currentUserFeedback,
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
