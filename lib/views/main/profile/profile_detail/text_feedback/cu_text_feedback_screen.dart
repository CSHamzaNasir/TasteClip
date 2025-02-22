import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'cu_text_feedback_controller.dart';

import 'package:get/get.dart';

class FeedbackScreen extends StatelessWidget {
  final controller = Get.put(FeedbackController());

  FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: Obx(() {
          if (controller.feedbackList.isEmpty) {
            return Center(child: Text("Loading..."));
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
                  child: Text("Text Feedback",
                      style: AppTextStyles.boldBodyStyle
                          .copyWith(color: AppColors.lightColor)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.feedbackList.length,
                  itemBuilder: (context, index) {
                    var feedback = controller.feedbackList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.mainColor),
                          color: AppColors.mainColor.withCustomOpacity(.1)),
                      child: Column(
                        spacing: 16,
                        children: [
                          Row(
                            spacing: 12,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: (feedback['branchThumbnail'] !=
                                            null &&
                                        feedback['branchThumbnail'].isNotEmpty)
                                    ? NetworkImage(feedback['branchThumbnail'])
                                    : null,
                                child: (feedback['branchThumbnail'] == null ||
                                        feedback['branchThumbnail'].isEmpty)
                                    ? Icon(Icons.image_not_supported, size: 25)
                                    : null,
                              ),
                              Text(
                                feedback['branch'],
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: AppColors.mainColor,
                                  fontFamily: AppFonts.sandSemiBold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            feedback['feedback_text'],
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.mainColor.withCustomOpacity(
                                .7,
                              ),
                            ),
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              Text('Rating:',
                                  style: AppTextStyles.regularStyle.copyWith(
                                    color: AppColors.mainColor,
                                    fontFamily: AppFonts.sandBold,
                                  )),
                              Text(
                                feedback['rating'],
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: const Color(0xFFAB8104),
                                ),
                              ),
                              Spacer(),
                              Text(
                                feedback['created_at'],
                                style: AppTextStyles.lightStyle.copyWith(
                                  color: AppColors.mainColor,
                                  fontFamily: AppFonts.sandSemiBold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
