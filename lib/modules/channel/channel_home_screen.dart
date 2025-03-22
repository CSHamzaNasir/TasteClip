import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'components/channel_home_appbar.dart';
import 'components/meal_category.dart';
import 'components/popular_feedback.dart';

class ChannelHomeScreen extends StatelessWidget {
  const ChannelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChannelHomeAppBar(
              image: "",
              username: 'username',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      1.vertical,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: AppTextStyles.boldBodyStyle
                                .copyWith(color: AppColors.textColor),
                          ),
                          Text(
                            "See All",
                            style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: AppFonts.sandSemiBold),
                          )
                        ],
                      ),
                      MealCategoryRow(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Most Popular",
                            style: AppTextStyles.boldBodyStyle
                                .copyWith(color: AppColors.textColor),
                          ),
                          Text(
                            "See All",
                            style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: AppFonts.sandSemiBold),
                          ),
                        ],
                      ),
                      PopularFeedback(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Feedbacker",
                            style: AppTextStyles.boldBodyStyle
                                .copyWith(color: AppColors.textColor),
                          ),
                          Text(
                            "See All",
                            style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: AppFonts.sandSemiBold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
