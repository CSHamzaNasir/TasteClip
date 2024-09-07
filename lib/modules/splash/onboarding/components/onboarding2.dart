import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../../config/app_assets.dart';
import '../../../../config/app_text_styles.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAssets.vision,
          width: 250,
        ),
        50.vertical,
        const Text(
          'Our Vision',
          style: AppTextStyles.semiBoldStyle,
        ),
        16.vertical,
        const Text(
          'We\'re on a mission to empower your voice. Join us in shaping better dining experiences together.',
          textAlign: TextAlign.center,
          style: AppTextStyles.thinStyle,
        ),
      ],
    );
  }
}
