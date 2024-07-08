import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/theme/text_style.dart';

class OnboardingElevatedButton extends StatelessWidget {
  const OnboardingElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double imgWidth;
    double imgHeight;
    if (screenWidth < 300) {
      imgWidth = 200.0;
      imgHeight = 40.0;
    } else if (screenWidth < 350) {
      imgWidth = 300.0;
      imgHeight = 45.0;
    } else {
      imgWidth = 360.0;
      imgHeight = 50.0;
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed('/role');
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: mainColor,
          minimumSize: Size(imgWidth, imgHeight),
        ),
        child: Text('Get Started', style: AppTextStyles.style8),
      ),
    );
  }
}
