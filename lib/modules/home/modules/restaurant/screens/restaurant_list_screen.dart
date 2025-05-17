import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/home/modules/restaurant/components/restaurant_card.dart';
import 'package:tasteclip/modules/home/modules/restaurant/components/restaurant_search_card.dart';

import '../../../../../config/app_text_styles.dart';
import '../controllers/restaurant_list_controller.dart';

class RestaurantListScreen extends StatelessWidget {
  final controller = Get.put(RestaurantListController());

  RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        title: Text(
          "All Restaurants",
          style: AppTextStyles.headingStyle1.copyWith(
            color: AppColors.textColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.textColor),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RestaurantSearchDelegate(controller),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (controller.hasError.value) {
          return Center(child: Text("Error: ${controller.errorMessage}"));
        } else if (controller.displayedRestaurants.isEmpty) {
          return Center(
            child: Text(
              controller.isSearchActive.value
                  ? "No restaurants found matching your search."
                  : "No restaurants found.",
              style:
                  AppTextStyles.bodyStyle.copyWith(color: AppColors.textColor),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Container(
              color: AppColors.whiteColor,
              child: ListView.builder(
                itemCount: controller.displayedRestaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = controller.displayedRestaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              ),
            ),
          );
        }
      }),
    );
  }
}
