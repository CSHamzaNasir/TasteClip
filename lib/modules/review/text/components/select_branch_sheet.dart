import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/review/text/post_text_feedback_screen.dart';
import 'package:tasteclip/utils/app_string.dart';

import '../../../../widgets/app_button.dart';

class SelectBranchSheetText extends StatefulWidget {
  final String restaurantName;

  const SelectBranchSheetText({super.key, required this.restaurantName});

  @override
  SelectBranchSheetTextState createState() => SelectBranchSheetTextState();
}

class SelectBranchSheetTextState extends State<SelectBranchSheetText> {
  List<Map<String, dynamic>> _branches = [];
  String? _selectedBranch;
  List<Map<String, dynamic>> _filteredBranches = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> _fetchBranches() async {
    try {
      DocumentSnapshot restaurantDoc = await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.restaurantName.toLowerCase())
          .get();

      if (restaurantDoc.exists) {
        List<dynamic> branches = restaurantDoc['branches'] ?? [];
        setState(() {
          _branches = branches
              .map((branch) => {'name': branch['branchAddress']})
              .toList();
          _filteredBranches = List.from(_branches);
        });
      }
    } catch (e) {
      log("Error fetching branches: $e");
    }
  }

  void _filterBranches(String query) {
    setState(() {
      _filteredBranches = _branches
          .where((branch) =>
              branch['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchBranches();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
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
              TextField(
                controller: _searchController,
                onChanged: _filterBranches,
                decoration: InputDecoration(
                  hintText: 'Search branch',
                  prefixIcon: Icon(Icons.search, color: AppColors.greyColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              16.vertical,
              _filteredBranches.isEmpty
                  ? const Center(child: CupertinoActivityIndicator())
                  : Column(
                      children: _filteredBranches.map((branch) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
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
                                  branch['name'],
                                  style: AppTextStyles.bodyStyle.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                                ),
                                const Spacer(),
                                Radio<String>(
                                  value: branch['name'],
                                  groupValue: _selectedBranch,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedBranch = value;
                                    });
                                  },
                                  activeColor: AppColors.mainColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
              20.vertical,
              AppButton(
                text: 'Next',
                onPressed: () {
                  if (_selectedBranch != null) {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => PostTextFeedbackScreen(
                        restaurantName: widget.restaurantName,
                        branchName: _selectedBranch!,
                      ),
                    );
                  } else {
                    log('No branch selected!');
                  }
                },
                buttonIsUnselect: _selectedBranch != null ? false : true,
              ),
              16.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
