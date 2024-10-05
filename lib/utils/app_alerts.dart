import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/utils/app_string.dart';

class CustomDialog extends StatelessWidget {
  final bool isSuccess;
  final String message;

  const CustomDialog({
    super.key,
    required this.message,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            isSuccess ? AppAssets.successIcon : AppAssets.errorIcon,
            height: 60,
          ),
          const SizedBox(height: 16),
          Text(
            isSuccess ? AppString.congratulations : AppString.error,
            style: AppTextStyles.mediumStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.thinStyle,
          ),
        ],
      ),
    );
  }
}
