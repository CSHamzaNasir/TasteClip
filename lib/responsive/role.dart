import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';

class RoleBtnProperties {
  final double title;
  final double subTitle;

  RoleBtnProperties({
    required this.title,
    required this.subTitle,
  });
}

class RoleBtn {
  static RoleBtnProperties boardingImgSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double title;
    double subTitle;

    if (screenWidth < 300 || screenHeight < 400) {
      title = h4;
      subTitle = h5;
    } else if (screenWidth < 350 || screenHeight < 500) {
      title = h4;
      subTitle = h5;
    } else {
      title = h2;
      subTitle = h3;
    }

    return RoleBtnProperties(
      title: title,
      subTitle: subTitle,
    );
  }
}
