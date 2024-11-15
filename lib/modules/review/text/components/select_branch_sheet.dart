import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';

import '../../../../widgets/app_button.dart';
import 'post_text_feedback_screen.dart';

class SelectBranchSheet extends StatefulWidget {
  const SelectBranchSheet({super.key});

  @override
  SelectBranchSheetState createState() => SelectBranchSheetState();
}

class SelectBranchSheetState extends State<SelectBranchSheet> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppString.selectBranch,
              style: AppTextStyles.headingStyle1.copyWith(
                color: AppColors.mainColor,
              ),
            ),
          ),
          16.vertical,
          const Text(
            AppString.selectResturentDes,
            style: AppTextStyles.bodyStyle,
          ),
          16.vertical,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.greyColor,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  'Branch Name',
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
                const Spacer(),
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  activeColor: AppColors.mainColor,
                  side: const BorderSide(color: AppColors.mainColor),
                ),
              ],
            ),
          ),
          20.vertical,
          AppButton(
            isGradient: _isChecked,
            text: 'Next',
            onPressed: _isChecked
                ? () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const PostTextFeedbackScreen(),
                    );
                  }
                : () {},
            btnColor: _isChecked ? null : AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
