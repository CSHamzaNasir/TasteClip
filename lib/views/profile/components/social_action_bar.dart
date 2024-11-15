import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/gradient_box.dart';

class SocialActionCard extends StatelessWidget {
  const SocialActionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GradientBox(
      widthFactor: 1,
      heightFactor: 0.17,
      gradientColors: const [
        AppColors.primaryColor,
        AppColors.mainColor,
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppString.likes,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
                Text(
                  AppString.comment,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
                Text(
                  AppString.share,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
