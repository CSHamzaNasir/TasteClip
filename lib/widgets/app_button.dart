import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';

class AppButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool btnSideClr;
  final bool isLoading;
  final double? btnRadius;
  final bool isGradient;
  final Color? btnColor;
  final bool buttonIsUnselect;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.btnSideClr = false,
    this.isLoading = false,
    this.btnRadius,
    this.isGradient = true,
    this.btnColor,
    this.buttonIsUnselect = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool showIcon = screenWidth > 300;

    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(btnRadius ?? 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: isGradient
              ? LinearGradient(
                  colors: buttonIsUnselect
                      ? [AppColors.btnUnSelectColor, AppColors.btnUnSelectColor]
                      : [
                          AppColors.textColor,
                          AppColors.mainColor,
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: !isGradient ? btnColor : null,
          borderRadius: BorderRadius.circular(btnRadius ?? 12),
          border: btnSideClr
              ? Border.all(color: AppColors.primaryColor, width: 1)
              : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: isLoading
            ? const SpinKitThreeBounce(
                color: AppColors.lightColor,
                size: 20.0,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null && showIcon)
                    Icon(
                      icon,
                      size: 16,
                      color: AppColors.lightColor,
                    ),
                  if (icon != null && showIcon) const SizedBox(width: 8),
                  Text(
                    text,
                    style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.whiteColor,
                        fontFamily: AppFonts.sandBold),
                  ),
                ],
              ),
      ),
    );
  }
}
