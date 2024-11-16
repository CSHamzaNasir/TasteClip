import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<Map<String, dynamic>> _branches = [];

  Future<void> _fetchBranches() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('channel-data').get();
      setState(() {
        _branches = snapshot.docs.map((doc) {
          return {
            'name': doc['branch_name'],
            'isChecked': false,
          };
        }).toList();
      });
    } catch (e) {
      log("Error fetching branches: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBranches();
  }

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
          // Displaying the branch names dynamically
          _branches.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: _branches.map((branch) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.greyColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            branch['name'], // Displaying branch name
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.mainColor,
                            ),
                          ),
                          const Spacer(),
                          Checkbox(
                            value: branch['isChecked'],
                            onChanged: (bool? value) {
                              setState(() {
                                branch['isChecked'] = value ?? false;
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
                    );
                  }).toList(),
                ),
          20.vertical,
          AppButton(
            isGradient: _branches.any((branch) => branch['isChecked']),
            text: 'Next',
            onPressed: () {
              if (_branches.any((branch) => branch['isChecked'])) {
                // Proceed to the next screen if at least one branch is selected
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const PostTextFeedbackScreen(),
                );
              }
            },
            btnColor: _branches.any((branch) => branch['isChecked'])
                ? null
                : AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
