import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';

class ChannelHomeScreen extends StatelessWidget {
  const ChannelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
        isLight: true,
        child: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.mainColor,
                ),
                child: Text(AppString.videos,
                    style: AppTextStyles.bodyStyle
                        .copyWith(color: AppColors.whiteColor)),
              )
            ],
          ),
        ));
  }
}
