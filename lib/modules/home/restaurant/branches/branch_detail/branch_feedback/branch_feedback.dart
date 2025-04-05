import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/home/restaurant/branches/branch_detail/branch_feedback/branch_feedback_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

class BranchFeedbackScreen extends StatelessWidget {
  const BranchFeedbackScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BranchFeedbackController());

    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: Obx(() {
          if (controller.feedbackListText.isEmpty) {
            return Center(child: Text("Loading..."));
          }
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50)),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: Text(
                        "Text Feedback",
                        style: AppTextStyles.boldBodyStyle
                            .copyWith(color: AppColors.lightColor),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -25,
                    left: 16,
                    right: 0,
                    child: Row(
                      spacing: 12,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle),
                          child: Image.asset(
                            width: 24,
                            height: 24,
                            AppAssets.breakfast,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle),
                          child: Image.asset(
                            width: 24,
                            height: 24,
                            AppAssets.lunch,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle),
                          child: Image.asset(
                            width: 24,
                            height: 24,
                            AppAssets.dinner,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.feedbackListText.length,
                  itemBuilder: (context, index) {
                    var feedbackText = controller.feedbackListText[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(bottom: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.mainColor),
                          color: AppColors.mainColor.withCustomOpacity(.1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    (feedbackText['branchThumbnail'] != null &&
                                            feedbackText['branchThumbnail']
                                                .isNotEmpty)
                                        ? NetworkImage(
                                            feedbackText['branchThumbnail'])
                                        : null,
                                child: (feedbackText['branchThumbnail'] ==
                                            null ||
                                        feedbackText['branchThumbnail'].isEmpty)
                                    ? Icon(Icons.image_not_supported, size: 25)
                                    : null,
                              ),
                              12.horizontal,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feedbackText['branch'],
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontFamily: AppFonts.sandSemiBold,
                                    ),
                                  ),
                                  Text(
                                    feedbackText['restaurantName'],
                                    style: AppTextStyles.regularStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontFamily: AppFonts.sandSemiBold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          16.vertical,
                          Text(
                            feedbackText['review'],
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.mainColor.withCustomOpacity(.7),
                            ),
                          ),
                          8.vertical,
                          Row(
                            children: [
                              Text('Rating:',
                                  style: AppTextStyles.regularStyle.copyWith(
                                    color: AppColors.mainColor,
                                    fontFamily: AppFonts.sandBold,
                                  )),
                              4.horizontal,
                              Text(
                                feedbackText['rating'],
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: const Color(0xFFAB8104),
                                ),
                              ),
                              Spacer(),
                              Text(
                                feedbackText['created_at'],
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
