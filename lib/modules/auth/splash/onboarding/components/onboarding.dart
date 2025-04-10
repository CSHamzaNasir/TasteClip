import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        38.vertical,
        SvgPicture.asset(
          AppAssets.welcome,
          width: 250,
        ),
        50.vertical,
        Text(AppString.welcomeToTaste,
            style: AppTextStyles.boldBodyStyle.copyWith(
              color: AppColors.textColor,
            )),
        16.vertical,
        const Text(
          AppString.letMakeYourFeedback,
          textAlign: TextAlign.center,
          style: AppTextStyles.lightStyle,
        )
      ],
    );
  }
}
