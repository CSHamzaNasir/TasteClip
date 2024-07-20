import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';

import '../../responsive/boarding.dart';

class OnboardingNextIcon extends StatelessWidget {
  const OnboardingNextIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BoardingResponsiveProperties properties =
        BoardingResponsive.boardingImgSize(context);
    return CircleAvatar(
      radius: properties.subTitle,
      backgroundColor: secondaryColor,
      child: const Icon(
        Icons.arrow_forward,
        color: lightColor,
        size: 17,
      ),
    );
  }
}
