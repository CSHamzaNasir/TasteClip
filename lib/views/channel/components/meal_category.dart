import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

class MealCategoryRow extends StatelessWidget {
  final List<Map<String, String>> mealCategories = [
    {"image": AppAssets.categoryFilter, "title": "Breakfast"},
    {"image": AppAssets.categoryFilter, "title": "Lunch"},
    {"image": AppAssets.categoryFilter, "title": "Dinner"},
  ];

  MealCategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: mealCategories.map((category) {
        return Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  category["image"]!,
                  width: screenWidth / 3.5,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: screenWidth / 3.5,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withCustomOpacity(0.4),
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    category["title"]!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
