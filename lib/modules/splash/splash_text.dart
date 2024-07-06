import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/modules/onboarding/onboarding.dart';
import '../../theme/style.dart';

class SplashText extends StatelessWidget {
  const SplashText({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const Onboarding(), transition: Transition.rightToLeft);
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Center(
            child: Text(
              'Taste Clip',
              style: AppTextStyles.style3,
            ),
          ),
          const Spacer(),
          Text(
            'Version 1.0',
            style: AppTextStyles.style2,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}