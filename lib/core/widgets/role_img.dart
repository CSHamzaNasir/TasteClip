import 'package:flutter/material.dart';
import 'package:tasteclip/constant/assets_path.dart';

class RoleImg extends StatelessWidget {
  const RoleImg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double imgWidth;
    double imgHeight;
    if (screenWidth < 300) {
      imgWidth = 120.0;
      imgHeight = 80.0;
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
