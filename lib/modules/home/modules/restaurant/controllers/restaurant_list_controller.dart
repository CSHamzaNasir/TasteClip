import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/utils/app_alert.dart';

class RestaurantListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var restaurants = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var filteredRestaurants = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;
  var isSearchActive = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllRestaurants();
  }

  void fetchAllRestaurants() async {
    isLoading(true);
    hasError(false);
    restaurants.clear();

    try {
      QuerySnapshot restaurantQuery =
          await _firestore.collection('restaurants').get();

      restaurants.assignAll(restaurantQuery.docs.map((doc) {
        return {
          "restaurantId": doc.id,
          "restaurantName": doc['restaurantName'] ?? 'Unknown Restaurant',
          "branches": doc['branches'] ?? [],
        };
      }).toList());
      filteredRestaurants.assignAll(restaurants);
    } catch (e) {
      hasError(true);
      errorMessage(e.toString());
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    } finally {
      isLoading(false);
    }
  }

  void filterRestaurants(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredRestaurants.assignAll(restaurants);
      isSearchActive.value = false;
    } else {
      filteredRestaurants.assignAll(restaurants.where((restaurant) {
        final name = restaurant['restaurantName'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList());
      isSearchActive.value = true;
    }
  }

  List<Map<String, dynamic>> get displayedRestaurants {
    return isSearchActive.value ? filteredRestaurants : restaurants;
  }

  void showFeedbackDialog(String restaurantName) {
    List<Map<String, dynamic>> feedbackOptions = [
      {'icon': AppAssets.message, 'label': "Text"},
      {'icon': AppAssets.camera, 'label': "Image"},
      {'icon': AppAssets.video, 'label': "Video"},
    ];

    Get.dialog(
      Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Feedback Option',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                12.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: feedbackOptions.map((option) {
                    return Column(
                      children: [
                        SvgPicture.asset(option['icon'], width: 24, height: 24),
                        8.vertical,
                        Text(option['label']),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
