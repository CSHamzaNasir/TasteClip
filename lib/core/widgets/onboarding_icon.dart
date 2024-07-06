import 'package:flutter/material.dart';
import 'package:tasteclip/theme/style.dart';

class OnboardingNextIcon extends StatelessWidget {
  const OnboardingNextIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 15.0,
      backgroundColor: secondaryColor,
      child: Icon(
        Icons.arrow_forward,
        color: lightColor,
        size: 17,
      ),
    );
  }
}
