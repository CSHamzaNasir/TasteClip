import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import '../../../../widgets/app_button.dart';
import 'select_branch_sheet.dart';

class SelectRestaurantSheetImage extends StatefulWidget {
  const SelectRestaurantSheetImage({super.key});

  @override
  SelectRestaurantSheetImageState createState() =>
      SelectRestaurantSheetImageState();
}

class SelectRestaurantSheetImageState extends State<SelectRestaurantSheetImage> {
  List<Map<String, dynamic>> _restaurants = [];

  Future<void> _fetchRestaurants() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('restaurants').get();
      setState(() {
        _restaurants = snapshot.docs.map((doc) {
          return {
            'name': doc.id,
            'isChecked': false,
          };
        }).toList();
      });
    } catch (e) {
      log("Error fetching restaurants: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
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
              AppString.selectResturent,
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
          _restaurants.isEmpty
              ? const Center(child: CupertinoActivityIndicator())
              : Column(
                  children: _restaurants.map((restaurant) {
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
                              restaurant['name'],
                              style: AppTextStyles.bodyStyle.copyWith(
                                color: AppColors.mainColor,
                              ),
                            ),
                            const Spacer(),
                            Checkbox(
                              value: restaurant['isChecked'],
                              onChanged: (bool? value) {
                                setState(() {
                                  restaurant['isChecked'] = value ?? false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              activeColor: AppColors.mainColor,
                              side:
                                  const BorderSide(color: AppColors.mainColor),
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
              if (_restaurants.any((restaurant) => restaurant['isChecked'])) {
                String? restaurantName = _restaurants.firstWhere(
                  (restaurant) => restaurant['isChecked'] == true,
                )['name'];

                if (restaurantName != null) {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SelectBranchSheetImage(
                      restaurantName: restaurantName,
                    ),
                  );
                } else {
                  log('No restaurant selected!');
                }
              }
            },
            buttonIsUnselect:
                _restaurants.any((restaurant) => restaurant['isChecked'])
                    ? false
                    : true,
          ),
          16.vertical,
        ],
      ),
    );
  }
}
