import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/manager_auth/manager_profile/manager_profile_update.dart';

class ChannelHomeAppBar extends StatelessWidget {
  final String? image;
  final String? username;
  final String? actionImage;
  final VoidCallback? onActionTap;
  final GlobalKey? actionKey;

  const ChannelHomeAppBar({
    super.key,
    this.image,
    this.username,
    this.actionImage,
    this.onActionTap,
    this.actionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16).copyWith(top: 50),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        spacing: 24,
        children: [
          Row(
            spacing: 16,
            children: [
              GestureDetector(
                onTap: () => Get.to(() => UpdateBranchImageScreen()),
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 24,
                  backgroundImage: image != null
                      ? NetworkImage(image!)
                      : AssetImage(AppAssets.dummyImg),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    username ?? "Loading...",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Text(
                    "Check Amazing Feedback..",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontFamily: AppFonts.sandRegular,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                key: actionKey,
                onTap: onActionTap,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.logout,
                    colorFilter: ColorFilter.mode(
                      AppColors.mainColor,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
          
          
          
          
          
          
          
          
        ],
      ),
    );
  }
}
