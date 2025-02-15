import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/constant/app_colors.dart';

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
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyles.boldBodyStyle.copyWith(
          color: isDark == 'true' ? AppColors.whiteColor : AppColors.textColor,
        ),
      ),
      elevation: 10.0,
      leadingWidth: 70,
      backgroundColor:
          isDark == 'true' ? AppColors.mainColor : AppColors.lightColor,
      leading: showBackIcon
          ? IconButton(
              onPressed: onTap ?? () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              color:
                  isDark == 'true' ? AppColors.lightColor : AppColors.mainColor,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 4.0);
}
