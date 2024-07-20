import 'package:flutter/material.dart';

class ResponsiveSize {
  static Map<String, double> getButtonSizes(BuildContext context) {
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
      screenSpacing = screenHeight * 0.02;
    } else if (screenWidth < 350) {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 45.0;
      googlePhoneBtnWidth = 120.0;
      googlePhoneBtnHeight = 40.0;
      screenSpacing = screenHeight * 0.03;
    } else {
      loginSignupBtnWidth = double.infinity;
      loginSignupBtnHeight = 50.0;
      googlePhoneBtnWidth = 150.0;
      googlePhoneBtnHeight = 48.0;
      screenSpacing = screenHeight * 0.05;
    }

    return {
      'loginSignupBtnWidth': loginSignupBtnWidth,
      'loginSignupBtnHeight': loginSignupBtnHeight,
      'googlePhoneBtnWidth': googlePhoneBtnWidth,
      'googlePhoneBtnHeight': googlePhoneBtnHeight,
      'screenSpacing': screenSpacing,
    };
  }
}
