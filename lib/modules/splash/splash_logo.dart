import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/modules/splash/splash_text.dart';
import 'package:tasteclip/theme/style.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.to(
        () => const SplashText(),
        transition: Transition.fadeIn,
        duration: const Duration(seconds: 3),
      );
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
              child: Column(
            children: [
              Text(
                'TasteClip',
                style: AppTextStyles.style1,
              ),
              Text(
                'Version 1.0',
                style: AppTextStyles.style2,
              ),
              SizedBox(
                height: Get.height * 0.03,
              )
            ],
          ))
        ],
      ),
    );
  }
}
