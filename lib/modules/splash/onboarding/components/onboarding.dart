import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

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
        const Text(
          'Welcome to TasteClip',
          style: AppTextStyles.semiBoldStyle,
        ),
        16.vertical,
        const Text(
          'Let\'s make your feedback matter. Get started in seconds and share your experiences effortlessly.',
          textAlign: TextAlign.center,
          style: AppTextStyles.thinStyle,
        )
      ],
    );
  }
}
