import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../constant/app_colors.dart';

class OrContinueWith extends StatelessWidget {
  const OrContinueWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.primaryColor,
          ),
        ),
        8.horizontal,
        Text(
          'Or Continue with',
          style: AppTextStyles.buttonStyle1.copyWith(
            color: AppColors.mainColor,
          ),
        ),
        8.horizontal,
        const Expanded(
          child: Divider(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
