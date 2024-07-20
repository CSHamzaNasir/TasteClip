import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';

class BoardingResponsiveProperties {
  final double width;
  final double height;
  final double title;
  final double subTitle;
  final double btnHeight;
  final double btnWidth;
  final double btnText;

  BoardingResponsiveProperties({
    required this.width,
    required this.height,
    required this.title,
    required this.subTitle,
    required this.btnHeight,
    required this.btnWidth,
    required this.btnText,
  });
}

class BoardingResponsive {
  static BoardingResponsiveProperties boardingImgSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double imgWidth;
    double imgHeight;
    double title;
    double subTitle;
    double btnHeight;
    double btnWidth;
    double btnText;

    if (screenWidth < 300 || screenHeight < 400) {
      imgWidth = 120;
      imgHeight = 120;
      btnHeight = 30;
      btnWidth = 150;
      title = h5;
      subTitle = h6;
      btnText = h6;
    } else if (screenWidth < 350 || screenHeight < 500) {
      imgWidth = 150;
      imgHeight = 150;
      btnHeight = 40;
      btnWidth = 200;
      title = h4;
      subTitle = h6;
      btnText = h5;
    } else {
      imgWidth = 250;
      imgHeight = 250;
      btnHeight = 60;
      btnWidth = 300;
      title = h2;
      subTitle = h5;
      btnText = h4;
    }

    return BoardingResponsiveProperties(
      width: imgWidth,
      height: imgHeight,
      title: title,
      subTitle: subTitle,
      btnHeight: btnHeight,
      btnWidth: btnWidth,
      btnText: btnText,
    );
  }
}
