import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

class ChannelTopWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final int? count;

  const ChannelTopWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border:
              Border.all(color: AppColors.primaryColor.withCustomOpacity(.5)),
          borderRadius: BorderRadius.circular(12),
          color: AppColors.mainColor.withCustomOpacity(.2),
        ),
        child: Stack(
          children: [
            Column(
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
            if (count != null && count! > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      count!.toString(),
                      style: AppTextStyles.regularStyle.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
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
