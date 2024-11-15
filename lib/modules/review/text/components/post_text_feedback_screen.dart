import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_feild.dart';

import '../../../../widgets/app_button.dart';
import 'select_branch_sheet.dart';

class PostTextFeedbackScreen extends StatefulWidget {
  const PostTextFeedbackScreen({super.key});

  @override
  PostTextFeedbackScreenState createState() => PostTextFeedbackScreenState();
}

class PostTextFeedbackScreenState extends State<PostTextFeedbackScreen> {
  final bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.vertical,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppString.describeYourThoughts,
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
              const AppFeild(hintText: AppString.enterYourFeedbackHere),
              16.vertical,
              const AppFeild(hintText: 'Enter your rating'),
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
                          builder: (context) => const SelectBranchSheet(),
                        );
                      }
                    : () {},
                btnColor: _isChecked ? null : AppColors.greyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
