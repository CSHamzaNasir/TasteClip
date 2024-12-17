import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../constant/app_colors.dart';

class UserProfileCard extends StatelessWidget {
  final String title1;
  final String title2;
  final String image1;
  final String image2;
  const UserProfileCard({
    super.key,
    required this.title1,
    required this.title2,
    required this.image1,
    required this.image2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.whiteColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(image1),
                20.horizontal,
                Text(title1,
                    style: AppTextStyles.bodyStyle 
                        .copyWith(color: AppColors.mainColor)),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.mainColor,
                  size: 18,
                )
              ],
            ),
            const Divider(
              color: AppColors.mainColor,
            ),
            Row(
              children: [
                SvgPicture.asset(image2),
                20.horizontal,
                Text(title2,
                    style: AppTextStyles.bodyStyle
                        .copyWith(color: AppColors.mainColor)),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.mainColor,
                  size: 18,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
