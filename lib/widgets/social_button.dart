import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../constant/app_colors.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;
  const SocialButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        decoration: const BoxDecoration(
            color: AppColors.lightColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            SvgPicture.asset(
              colorFilter:
                  const ColorFilter.mode(AppColors.mainColor, BlendMode.srcIn),
              height: 20,
              icon,
            ),
            10.horizontal,
            Text(
              title,
              style: AppTextStyles.buttonStyle1.copyWith(
                color: AppColors.mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
