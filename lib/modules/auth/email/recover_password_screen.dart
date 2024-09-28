import 'package:flutter/material.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';

import '../../../config/app_text_styles.dart';
import '../../../constant/app_colors.dart';
import '../../../utils/app_string.dart';

class RecoverPasswordScreen extends StatelessWidget {
  const RecoverPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        isDark: true,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppString.recoverPassword,
            isDark: 'true',
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.forgetPassword,
                  style: AppTextStyles.mediumStyle.copyWith(
                    color: AppColors.lightColor,
                  ),
                ),
                16.vertical,
                Text(
                  AppString.weHaveSent,
                  style: AppTextStyles.thinStyle.copyWith(
                    color: AppColors.greyColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
