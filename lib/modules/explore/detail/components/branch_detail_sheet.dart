import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';

class BranchDetail extends StatelessWidget {
  const BranchDetail({
    super.key,
    required this.feedback,
  });

  final RxMap feedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.centerRight,
            child: Text("Branch Detail",
                style: AppTextStyles.bodyStyle
                    .copyWith(color: AppColors.mainColor))),
        Row(
          spacing: 16,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: (feedback['branchThumbnail'] != null &&
                      feedback['branchThumbnail'].isNotEmpty)
                  ? NetworkImage(feedback['branchThumbnail'])
                  : null,
              child: (feedback['branchThumbnail'] == null ||
                      feedback['branchThumbnail'].isEmpty)
                  ? Icon(Icons.image_not_supported, size: 25)
                  : null,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedback['branch'] ?? "No branch",
                  style: AppTextStyles.boldBodyStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  feedback['restaurantName'] ?? "No restaurant name",
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ],
            )
          ],
        ),
        Text(
          "Total Feedback: 23",
          style: AppTextStyles.bodyStyle.copyWith(
            color: AppColors.textColor,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primaryColor),
            color: AppColors.mainColor.withCustomOpacity(.1),
          ),
          child: Row(
            children: [
              Text(
                "Channel profile",
                style: AppTextStyles.bodyStyle.copyWith(
                  fontFamily: AppFonts.sandSemiBold,
                  color: AppColors.mainColor,
                ),
              ),
              Spacer(),
              SvgPicture.asset(
                AppAssets.arrowNext,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.mainColor,
                  BlendMode.srcIn,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
