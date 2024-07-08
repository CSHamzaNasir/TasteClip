import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/theme/style.dart';

class RoleButton extends StatelessWidget {
  const RoleButton({
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
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/authentication');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: secondaryColor,
            minimumSize: Size(imgWidth, imgHeight),
          ),
          child: Text('User', style: AppTextStyles.style9),
        ),
        SizedBox(height: Get.height * 0.02),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: primaryColor,
            minimumSize: Size(imgWidth, imgHeight),
          ),
          child: Text('Guest', style: AppTextStyles.style9),
        ),
        SizedBox(height: Get.height * 0.02),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: lightColor,
            minimumSize: Size(imgWidth, imgHeight),
          ),
          child: Text('Restaurant Manager', style: AppTextStyles.style10),
        ),
      ],
    );
  }
}
