import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';

class SplashResponsiveProperties {
  final double title;
  final double subTitle;

  SplashResponsiveProperties({
    required this.title,
    required this.subTitle,
  });
}

class SplashResponsive {
  static SplashResponsiveProperties boardingImgSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double title;
    double subTitle;

    if (screenWidth < 300 || screenHeight < 400) {
      title = h5;
      subTitle = h6;
    } else if (screenWidth < 350 || screenHeight < 500) {
      title = h4;
      subTitle = h6;
    } else {
      title = h3;
      subTitle = h5;
    }

    return SplashResponsiveProperties(
      title: title,
      subTitle: subTitle,
    );
  }
}
