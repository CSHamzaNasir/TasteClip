import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/explore/detail/text_feedback_detail_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_fonts.dart';
import '../watch_feedback_controller.dart';

class TextFeedbackDisplay extends StatelessWidget {
  final FeedbackCategory category;
  final String? branchName;
  final FeedbackScope feedback;

  TextFeedbackDisplay({
    super.key,
    required this.controller,
    required this.category,
    this.branchName,
    required this.feedback,
  });

  final WatchFeedbackController controller;
  final textfeedbackController = Get.put(TextFeedbackDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final displayedFeedback = controller.feedbackListText;

      if (displayedFeedback.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActivityIndicator(),
              16.vertical,
              Text(
                'Loading...',
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.btnUnSelectColor,
                ),
              ),
            ],
          ),
        );
      }

      if (controller.feedbackListText.isEmpty) {
        return ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          itemBuilder: (context, index) {
            return const TextFeedbackShimmer();
          },
        );
      }

      return ListView.separated(
        itemCount: displayedFeedback.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
        ),
        itemBuilder: (context, index) {
          final feedbackText = displayedFeedback[index];
          final shouldHide = feedback == FeedbackScope.branchFeedback
              ? feedbackText['branch'] == branchName
              : true;
          return Visibility(
            visible: shouldHide,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withCustomOpacity(.95),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.btnUnSelectColor.withCustomOpacity(.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ProfileImageWithShimmer(
                          imageUrl: feedbackText['user_profileImage'],
                          radius: 18,
                        ),
                        12.horizontal,
                        Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feedbackText['user_fullName'] ?? "Unknown User",
                              style: AppTextStyles.bodyStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: AppFonts.sandSemiBold,
                              ),
                            ),
                            Text(
                              feedbackText['created_at'] ?? "",
                              style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.btnUnSelectColor,
                                fontFamily: AppFonts.sandSemiBold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    12.vertical,
                    Text(
                      feedbackText['review'] ?? "No feedback available",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.textColor.withCustomOpacity(.6),
                      ),
                    ),
                    24.vertical,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.toggleLikeFeedback(
                                feedbackText['feedbackId'],
                                feedbackText,
                              );
                            },
                            child: feedback == FeedbackScope.branchFeedback
                                ? Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.mainColor
                                            .withCustomOpacity(.1)),
                                    child: SvgPicture.asset(
                                        height: 18,
                                        width: 18,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          AppColors.mainColor
                                              .withCustomOpacity(.7),
                                          BlendMode.srcIn,
                                        ),
                                        AppAssets.likeThumb))
                                : SvgPicture.asset(
                                    controller
                                            .hasUserLikedFeedback(feedbackText)
                                        ? AppAssets.likeThumb
                                        : AppAssets.likeBorder,
                                    height: 18,
                                    width: 18,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.mainColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                          ),
                          Text(
                            '${feedbackText['likes']?.length ?? 0}',
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.mainColor,
                              fontFamily: AppFonts.sandBold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:
                                    AppColors.mainColor.withCustomOpacity(.1)),
                            child: SvgPicture.asset(
                                height: 18,
                                width: 18,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                  AppColors.mainColor.withCustomOpacity(.7),
                                  BlendMode.srcIn,
                                ),
                                AppAssets.messageFilled),
                          ),
                          GestureDetector(
                            onTap: () {
                              textfeedbackController.showAddCommentSheet(
                                context,
                                feedbackText['feedbackId'],
                              );
                            },
                            child: Text(
                              feedback == FeedbackScope.branchFeedback
                                  ? "Comments"
                                  : "Reply",
                              style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.textColor,
                                fontFamily: AppFonts.sandSemiBold,
                              ),
                            ),
                          ),
                          Container(
                            color: AppColors.mainColor.withCustomOpacity(.4),
                            height: 20,
                            width: 1,
                          ),
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:
                                    AppColors.mainColor.withCustomOpacity(.1)),
                            child: SvgPicture.asset(
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                AppColors.mainColor.withCustomOpacity(.7),
                                BlendMode.srcIn,
                              ),
                              AppAssets.menuIcon,
                            ),
                          ),
                          Text(
                            "Other",
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.textColor,
                              fontFamily: AppFonts.sandSemiBold,
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
