import 'package:flutter/material.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../constant/app_colors.dart';
import '../../../../utils/app_string.dart';
import '../../../../widgets/gradient_box.dart';

class UserControl extends StatelessWidget {
  const UserControl({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.settings_outlined,
                  size: 20,
                  color: AppColors.lightColor,
                ),
                12.horizontal,
                Text(
                  AppString.setting,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_outlined,
                  size: 20,
                  color: AppColors.lightColor,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.palette_outlined,
                  size: 20,
                  color: AppColors.lightColor,
                ),
                12.horizontal,
                Text(
                  AppString.theme,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_outlined,
                  size: 20,
                  color: AppColors.lightColor,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.logout_outlined,
                  size: 20,
                  color: AppColors.lightColor,
                ),
                12.horizontal,
                Text(
                  AppString.logout,
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.chevron_right_outlined,
                  size: 20,
                  color: AppColors.lightColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
