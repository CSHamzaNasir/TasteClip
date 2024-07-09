import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/modules/splash/splash_text.dart';
import 'package:tasteclip/theme/gradient.dart';
import 'package:tasteclip/theme/text_style.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double imgWidth;
    double imgHeight;
    if (screenWidth < 300) {
      imgWidth = 120.0;
      imgHeight = 80.0;
    } else if (screenWidth < 350) {
      imgWidth = 250.0;
      imgHeight = 300.0;
    } else {
      imgWidth = 200.0;
      imgHeight = 200.0;
    }

    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const SplashText(), transition: Transition.rightToLeft);
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: lightWhiteGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                width: imgWidth,
                height: imgHeight,
                child: Image.asset(appLogo),
              ),
              const Spacer(),
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
          ),
        ),
      ),
    );
  }
}
