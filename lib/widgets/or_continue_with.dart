import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../constant/app_colors.dart';

class OrContinueWith extends StatelessWidget {
  final bool isDarkMode;

  const OrContinueWith({
    super.key,
    this.isDarkMode = true,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? AppColors.mainColor : AppColors.lightColor;
    final dividerColor =
        isDarkMode ? AppColors.primaryColor : AppColors.lightColor;

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
          ),
        ),
        8.horizontal,
        Text(
          'Or Continue with',
          style: AppTextStyles.bodyStyle.copyWith(
            color: textColor,
          ),
        ),
        8.horizontal,
        Expanded(
          child: Divider(
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
