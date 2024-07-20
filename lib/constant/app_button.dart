import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final bool btnSideClr;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.btnSideClr = false,
  });

  @override
  Widget build(BuildContext context) {
    ButtonResponsiveProperties properties =
        ButtonResponsive.btnResponsive(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: btnSideClr ? primaryColor : Colors.transparent,
            width: 1,
          ),
        ),
        minimumSize: Size.fromHeight(properties.btnHeight),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 16,
            ),
          if (icon != null) const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}

class ButtonResponsiveProperties {
  final double btnHeight;

  ButtonResponsiveProperties({
    required this.btnHeight,
  });
}

class ButtonResponsive {
  static ButtonResponsiveProperties btnResponsive(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double btnHeight;

    if (screenWidth < 300 || screenHeight < 400) {
      btnHeight = 35;
    } else if (screenWidth < 350 || screenHeight < 500) {
      btnHeight = 40;
    } else {
      btnHeight = 50;
    }

    return ButtonResponsiveProperties(
      btnHeight: btnHeight,
    );
  }
}
