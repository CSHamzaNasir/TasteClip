import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_fonts.dart';
import 'branches/branches_list_screen.dart';
import 'restaurant_list_controller.dart';

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
          "All Restaurant",
          style: AppTextStyles.headingStyle1.copyWith(
            color: AppColors.textColor,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (controller.hasError.value) {
          return Center(child: Text("Error: ${controller.errorMessage}"));
        } else if (controller.restaurants.isEmpty) {
          return const Center(child: Text("No restaurants found."));
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ListView.builder(
              itemCount: controller.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = controller.restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              },
            ),
          );
        }
      }),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    List<dynamic> branches = restaurant['branches'] ?? [];
    return GestureDetector(
      onTap: () {
        Get.to(() => BranchesListScreen(
              restaurantId: restaurant['restaurantId'],
              restaurantName: restaurant['restaurantName'],
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.lightColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    AppAssets.userBgImg,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                16.horizontal,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant['restaurantName'],
                      style: AppTextStyles.boldBodyStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppAssets.arrowNext,
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    AppColors.mainColor,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            16.vertical,
            Text(
              "Click to check feedback",
              style: AppTextStyles.bodyStyle.copyWith(
                color: AppColors.textColor,
                fontFamily: AppFonts.sandMedium,
              ),
            ),
            Text(
              "${restaurant['branches'].length} Branches registered",
              style: AppTextStyles.lightStyle.copyWith(
                color: AppColors.textColor,
                fontFamily: AppFonts.sandMedium,
              ),
            ),
            16.vertical,
            SizedBox(
              height: 30,
              child: Stack(
                children: List.generate(
                  branches.length > 4 ? 4 : branches.length,
                  (index) {
                    return Positioned(
                      left: index * 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          branches[index]['branchThumbnail'],
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return CupertinoActivityIndicator();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red[300],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.error,
                                  size: 16, color: Colors.white),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
