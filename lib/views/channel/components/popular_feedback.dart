import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';

class PopularFeedback extends StatelessWidget {
  const PopularFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(AppAssets.categoryFilter),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:   EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                '4.8 (23 Reviews)',
                style: AppTextStyles.regularStyle.copyWith(
                    fontFamily: AppFonts.sandSemiBold,
                    color: AppColors.textColor),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.greyColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Burst Tomato Pasta",
                  style: AppTextStyles.bodyStyle.copyWith(
                    fontFamily: AppFonts.sandBold,
                    color: AppColors.textColor.withCustomOpacity(.8),
                  ),
                ),
                6.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "35 min ago",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.mainColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                    Text(
                      "by Hamza Nasir",
                      style: AppTextStyles.regularStyle
                          .copyWith(color: AppColors.mainColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
