import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double imgWidth;
    double imgHeight;
    if (screenWidth < 300 || screenHeight < 600) {
      imgWidth = double.infinity;
      imgHeight = 150.0;
    } else if (screenWidth < 350) {
      imgWidth = 250.0;
      imgHeight = 300.0;
    } else {
      imgWidth = 250.0;
      imgHeight = 250.0;
    }

    return SizedBox(
        width: imgWidth, height: imgHeight, child: Image.asset(appLogo));
  }
}
