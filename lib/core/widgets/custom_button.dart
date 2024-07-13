import 'package:flutter/material.dart';
import 'package:tasteclip/theme/text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final bool btnSideClr;

  const CustomButton({
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
        minimumSize: const Size.fromHeight(50),
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
