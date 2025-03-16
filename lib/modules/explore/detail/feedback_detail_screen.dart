import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/detail/image_feedback_detail_controller.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../config/app_text_styles.dart';

class FeedbackDetailScreen extends StatelessWidget {
  final FeedbackCategory category;
  final Map<String, dynamic> feedback;
 
  FeedbackDetailScreen(
      {super.key, required this.feedback, required this.category});

  final controller = Get.put(ImageFeedbackDetailController());

  @override
  Widget build(BuildContext context) {
    controller.setFeedback(feedback);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () => controller.showRestaurantSheet(context),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor, shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    AppAssets.info,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "Feedback Details",
          style: AppTextStyles.boldBodyStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Visibility(
         child: Stack(
          children: [
            Positioned.fill(
              child:
                  feedback['imageUrl'] != null && feedback['imageUrl'].isNotEmpty
                      ? Image.network(
                          feedback['imageUrl'],
                          fit: BoxFit.fitHeight,
                        )
                      : Container(color: Colors.grey),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withCustomOpacity(0.6),
                    Colors.black.withCustomOpacity(0.3),
                    Colors.black.withCustomOpacity(0.6),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 4,
                          children: [
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                feedback['branch'] ?? "No Title",
                                style: AppTextStyles.headingStyle1.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                            Icon(
                              size: 16,
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              feedback['rating'] ?? "0.0",
                              style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.textColor,
                              ),
                            )
                          ],
                        ),
                        Divider(color: AppColors.textColor),
                        Text(
                          feedback['description'] ?? "No Description",
                          style: AppTextStyles.bodyStyle.copyWith(
                            color: AppColors.textColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.access_time, size: 18, color: Colors.grey),
                            SizedBox(width: 6),
                            Text(
                              feedback['created_at']?.toString() ??
                                  "Unknown Date",
                              style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.textColor.withCustomOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        Obx(
                          () => AppButton(
                            text: controller.isBookmarked.value
                                ? "Bookmarked"
                                : "Add to bookmark",
                            onPressed: () => controller.toggleBookmark(),
                            btnRadius: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                  16.vertical,
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.whiteColor,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border, color: AppColors.mainColor),
                        4.horizontal,
                        Text("12",
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.mainColor,
                            )),
                        Spacer(),
                        GestureDetector(
                          onTap: () => controller.showAddCommentSheet(
                              context, feedback['feedbackId']),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              4.horizontal,
                              Text("Add comment",
                                  style: AppTextStyles.lightStyle.copyWith(
                                    color: AppColors.mainColor,
                                    fontFamily: AppFonts.sandBold,
                                  )),
                            ],
                          ),
                        ),
                        Spacer(),
                        InkWell(
                            onTap: () => controller.showCommentsSheet(
                                context, feedback["feedbackId"]),
                            child: Icon(Icons.comment_outlined,
                                color: AppColors.mainColor)),
                        4.horizontal,
                        Text("${controller.comments.length}",
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.mainColor,
                            )),
                      ],
                    ),
                  ),
                  12.vertical,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
