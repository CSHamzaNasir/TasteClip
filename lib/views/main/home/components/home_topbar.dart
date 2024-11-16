import 'package:flutter/material.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../constant/app_colors.dart';
import '../../../../widgets/gradient_box.dart';

class HomeTopBar extends StatelessWidget {
  final IconData icon;
  final String title;

  const HomeTopBar({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GradientBox(
      padding: 6,
      gradientColors: [
        AppColors.primaryColor,
        AppColors.mainColor,
      ],
      boxRadius: 100,
      widthFactor: 0.2,
      heightFactor: 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            icon,
            color: AppColors.lightColor,
          ),
          Text(
            title,
            style: AppTextStyles.lightStyle.copyWith(
              color: AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
