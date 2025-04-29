import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart'; 
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

class ChannelTopWidget extends StatelessWidget {
  final String title;
  final String icon;
  const ChannelTopWidget({
    super.key, required this.title, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          border:
              Border.all(color: AppColors.primaryColor.withCustomOpacity(.5)),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.mainColor.withCustomOpacity(.2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 6,
        children: [
          SvgPicture.asset(
            fit: BoxFit.cover,
            height: 24,
            width: 24,
            icon,
            colorFilter: ColorFilter.mode(
              AppColors.mainColor,
              BlendMode.srcIn,
            ),
          ),
          Text(
           title,
            style: AppTextStyles.regularStyle.copyWith(
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
