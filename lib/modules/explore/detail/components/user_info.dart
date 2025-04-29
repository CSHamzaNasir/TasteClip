import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:tasteclip/utils/text_shimmer.dart';

class UserInfoWidget extends StatelessWidget {
  final String userId;
  final UploadFeedbackModel feedback;
  final WatchFeedbackController controller;

  const UserInfoWidget({
    super.key,
    required this.userId,
    required this.feedback,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AuthModel?>(
      future: controller.getUserDetails(userId),
      builder: (context, snapshot) {
        final user = snapshot.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ProfileImageWithShimmer(
                  imageUrl: user?.profileImage,
                  radius: 20,
                ),
                12.horizontal,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? 'Unknown User',
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.whiteColor,
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    ),
                    4.vertical,
                    Text(
                      controller.formatDate(feedback.createdAt),
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.whiteColor.withCustomOpacity(.8),
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            12.vertical,
            Text(
              feedback.description,
              style: AppTextStyles.regularStyle
                  .copyWith(color: AppColors.whiteColor.withCustomOpacity(.9)),
            ),
            12.vertical,
            Row(
              spacing: 6,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.whiteColor.withCustomOpacity(.3)),
                  child: SvgPicture.asset(
                    colorFilter: ColorFilter.mode(
                      AppColors.whiteColor,
                      BlendMode.srcIn,
                    ),
                    AppAssets.branchIcon,
                  ),
                ),
                Text(
                  '${feedback.branchName} -',
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                Text(
                  feedback.restaurantName,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
