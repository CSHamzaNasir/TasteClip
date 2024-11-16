import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_colors.dart';

import '../../../../config/app_text_styles.dart';
import '../../../../widgets/gradient_box.dart';

class HomeContentCard extends StatelessWidget {
  final String imageIcon;
  final String title;
  final double? width;
  const HomeContentCard({
    super.key,
    required this.imageIcon,
    required this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GradientBox(
      padding: 10,
      gradientColors: [
        AppColors.primaryColor,
        AppColors.mainColor,
      ],
      boxRadius: 12,
      widthFactor: width ?? 0.45,
      heightFactor: 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 14,
              child: Image.asset(
                imageIcon,
                height: 17,
                width: 17,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                title,
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.lightColor,
                ),
              ),
              Spacer(),
              if (screenWidth >= 350)
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.lightColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
