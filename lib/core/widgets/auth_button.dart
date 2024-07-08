import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/theme/style.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double loginSignupBtnWidth;
    double loginSignupBtnHeight;
    double googlePhoneBtnWidth;
    double googlePhoneBtnHeight;
    if (screenWidth < 300) {
      loginSignupBtnWidth = 200.0;
      loginSignupBtnHeight = 40.0;
      googlePhoneBtnWidth = 100.0;
      googlePhoneBtnHeight = 37.0;
    } else if (screenWidth < 350) {
      loginSignupBtnWidth = 300.0;
      loginSignupBtnHeight = 45.0;
      googlePhoneBtnWidth = 120.0;
      googlePhoneBtnHeight = 40.0;
    } else {
      loginSignupBtnWidth = 360.0;
      loginSignupBtnHeight = 50.0;
      googlePhoneBtnWidth = 150.0;
      googlePhoneBtnHeight = 48.0;
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
        SizedBox(height: Get.height * 0.05),
        Row(children: [
          const Expanded(child: Divider(color: primaryColor)),
          Text(
            " or continue with ",
            style: AppTextStyles.style2,
          ),
          const Expanded(child: Divider(color: primaryColor)),
        ]),
        SizedBox(height: Get.height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
