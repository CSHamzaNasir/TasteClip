import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/widgets/app_background.dart';

enum ManagerApprovalStatus { pending, approved, rejected }

class ManagerApprovalScreen extends StatelessWidget {
  final ManagerApprovalStatus status;

  const ManagerApprovalScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                height: 60,
                AppAssets.reportIcon,
                colorFilter: ColorFilter.mode(
                  status == ManagerApprovalStatus.rejected
                      ? Colors.red
                      : AppColors.mainColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 20),
              _buildStatusMessage(),
              const SizedBox(height: 20),
              if (status == ManagerApprovalStatus.rejected)
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Contact Support ',
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.mainColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      ),
                      TextSpan(
                        text: "nasirhamza078@gmail.com",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.mainColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusMessage() {
    switch (status) {
      case ManagerApprovalStatus.pending:
        return Column(
          children: [
            Text(
              "Thanks for your registration",
              style: AppTextStyles.headingStyle1,
            ),
            Text(
              "Please wait until the admin approves your request",
              style: AppTextStyles.bodyStyle.copyWith(
                color: AppColors.mainColor,
              ),
            ),
          ],
        );
      case ManagerApprovalStatus.approved:
        return Column(
          children: [
            Text(
              "Your account has been approved!",
              style: AppTextStyles.headingStyle1,
            ),
            Text(
              "You can now access your manager dashboard",
              style: AppTextStyles.bodyStyle.copyWith(
                color: AppColors.mainColor,
              ),
            ),
          ],
        );
      case ManagerApprovalStatus.rejected:
        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your request has been rejected",
              style: AppTextStyles.headingStyle1.copyWith(
                color: Colors.red,
              ),
            ),
            Text(
              "Please contact support or reapply with correct information",
              style: AppTextStyles.bodyStyle.copyWith(
                color: AppColors.mainColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
    }
  }
}
