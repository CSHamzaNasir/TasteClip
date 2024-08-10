import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tasteclip/constant/app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final bool btnSideClr;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.btnSideClr = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    ButtonResponsiveProperties properties =
        ButtonResponsive.btnResponsive(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final bool showIcon = screenWidth > 300;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(properties.btnradius),
          side: BorderSide(
            color: btnSideClr ? primaryColor : Colors.transparent,
            width: 1,
          ),
        ),
        minimumSize: Size.fromHeight(properties.btnHeight),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLoading
            ? [
                SpinKitThreeBounce(
                  color: foregroundColor ?? Colors.white,
                  size: 20.0,
                ),
              ]
            : [
                if (icon != null && showIcon)
                  Icon(
                    icon,
                    size: 16,
                  ),
                if (icon != null && showIcon) const SizedBox(width: 8),
                Text(text),
              ],
      ),
    );
  }
}

class ButtonResponsiveProperties {
  final double btnHeight;
  final double btnradius;

  ButtonResponsiveProperties({
    required this.btnHeight,
    required this.btnradius,
  });
}

class ButtonResponsive {
  static ButtonResponsiveProperties btnResponsive(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double btnHeight;
    double btnradius;

    if (screenWidth < 300 || screenHeight < 400) {
      btnHeight = 35;
      btnradius = 6;
    } else if (screenWidth < 350 || screenHeight < 500) {
      btnHeight = 40;
      btnradius = 8;
    } else {
      btnHeight = 50;
      btnradius = 12;
    }

    return ButtonResponsiveProperties(
      btnHeight: btnHeight,
      btnradius: btnradius,
    );
  }
}
