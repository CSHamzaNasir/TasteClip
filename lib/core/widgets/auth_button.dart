import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/theme/text_style.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double loginSignupBtnWidth;
    double loginSignupBtnHeight;
    double googlePhoneBtnWidth;
    double googlePhoneBtnHeight;
    double screenSpacing;
    if (screenWidth < 300 || screenHeight < 600) {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 40.0;
      googlePhoneBtnWidth = 100.0;
      googlePhoneBtnHeight = 37.0;
      screenSpacing = Get.height * 0.02;
    } else if (screenWidth < 350) {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 45.0;
      googlePhoneBtnWidth = 120.0;
      googlePhoneBtnHeight = 40.0;
      screenSpacing = Get.height * 0.03;
    } else {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 50.0;
      googlePhoneBtnWidth = 150.0;
      googlePhoneBtnHeight = 48.0;
      screenSpacing = Get.height * 0.05;
    }
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/login');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: secondaryColor,
            minimumSize: Size(loginSignupBtnWidth, loginSignupBtnHeight),
          ),
          child: Text('Login', style: AppTextStyles.style9),
        ),
        SizedBox(height: Get.height * 0.02),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/signup');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: primaryColor,
            minimumSize: Size(loginSignupBtnWidth, loginSignupBtnHeight),
          ),
          child: Text('Sign Up', style: AppTextStyles.style9),
        ),
        SizedBox(height: screenSpacing),
        Row(children: [
          const Expanded(child: Divider(color: primaryColor)),
          Text(
            " or continue with ",
            style: AppTextStyles.style2,
          ),
          const Expanded(child: Divider(color: primaryColor)),
        ]),
        SizedBox(height: screenSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                minimumSize: Size(googlePhoneBtnWidth, googlePhoneBtnHeight),
              ),
              child: Text('Google', style: AppTextStyles.style10),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: primaryColor,
                minimumSize: Size(googlePhoneBtnWidth, googlePhoneBtnHeight),
              ),
              child: Text('Phone', style: AppTextStyles.style9),
            ),
          ],
        ),
      ],
    );
  }
}
