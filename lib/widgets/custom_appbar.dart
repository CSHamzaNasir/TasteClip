import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.isDark,
    this.onTap,
    this.showBackIcon = true,
  });

  final String title;
  final String? isDark;
  final VoidCallback? onTap;
  final bool showBackIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.boldBodyStyle.copyWith(
          color: isDark == 'true' ? AppColors.whiteColor : AppColors.textColor,
        ),
      ),
      elevation: 0,
      leadingWidth: 70,
      backgroundColor: AppColors.transparent,
      leading: showBackIcon
          ? IconButton(
              onPressed: onTap ?? () => Navigator.pop(context),
              icon: const Icon(
                size: 20,
                Icons.arrow_back_ios,
              ),
              color:
                  isDark == 'true' ? AppColors.lightColor : AppColors.textColor,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4.0);
}
