import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/theme/text_style.dart';

class RoleButton extends StatelessWidget {
  const RoleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double loginSignupBtnWidth;
    double loginSignupBtnHeight;

    if (screenWidth < 300 || screenHeight < 600) {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 40.0;
    } else if (screenWidth < 350 || screenHeight < 700) {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 45.0;
    } else {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 50.0;
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
            minimumSize: Size(loginSignupBtnWidth, loginSignupBtnHeight),
          ),
          child: Text('User', style: AppTextStyles.style9),
        ),
        SizedBox(height: Get.height * 0.02),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/guest');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: primaryColor,
            minimumSize: Size(loginSignupBtnWidth, loginSignupBtnHeight),
          ),
          child: Text('Guest', style: AppTextStyles.style9),
        ),
        SizedBox(height: Get.height * 0.03),
        Row(children: [
          const Expanded(child: Divider(color: primaryColor)),
          Text(
            " or continue with ",
            style: AppTextStyles.style2,
          ),
          const Expanded(child: Divider(color: primaryColor)),
        ]),
        SizedBox(height: Get.height * 0.03),
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/managerAuth');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: lightColor,
            minimumSize: Size(loginSignupBtnWidth, loginSignupBtnHeight),
          ),
          child: Text('Restaurant Manager', style: AppTextStyles.style10),
        ),
      ],
    );
  }
}
