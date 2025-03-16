import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';

import '../../../../widgets/app_button.dart';
import 'select_branch_sheet.dart';

class SelectRestaurantSheetImage extends StatefulWidget {
  const SelectRestaurantSheetImage({super.key});

  @override
  SelectRestaurantSheetImageState createState() =>
      SelectRestaurantSheetImageState();
}

class SelectRestaurantSheetImageState
    extends State<SelectRestaurantSheetImage> {
  List<Map<String, dynamic>> _restaurants = [];
  List<Map<String, dynamic>> _filteredRestaurants = [];
  final TextEditingController _searchController = TextEditingController();

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
        _filteredRestaurants = List.from(_restaurants);
      });
    } catch (e) {
      log("Error fetching restaurants: $e");
    }
  }

  void _filterRestaurants(String query) {
    setState(() {
      _filteredRestaurants = _restaurants
          .where((restaurant) =>
              restaurant['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
    _searchController.addListener(() {
      _filterRestaurants(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Add padding for the keyboard
        ),
        child: Container(
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
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Restaurant...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.search, color: AppColors.mainColor),
                ),
              ),
              16.vertical,
              _filteredRestaurants.isEmpty
                  ? const Center(child: CupertinoActivityIndicator())
                  : Column(
                      children: _filteredRestaurants.map((restaurant) {
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
                                  side: const BorderSide(
                                      color: AppColors.mainColor),
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
                  if (_restaurants
                      .any((restaurant) => restaurant['isChecked'])) {
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
        ),
      ),
    );
  }
}
