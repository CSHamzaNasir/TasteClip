import 'package:flutter/material.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/home/modules/restaurant/components/restaurant_card.dart';

import '../../../../../config/app_text_styles.dart';
import '../controllers/restaurant_list_controller.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  final RestaurantListController controller;
  late List<Map<String, dynamic>> _currentResults;

  RestaurantSearchDelegate(this.controller) {
    _currentResults = controller.restaurants;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: AppColors.textColor),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: AppColors.textColor),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _currentResults = controller.restaurants.where((restaurant) {
      final name = restaurant['restaurantName'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      _currentResults = controller.restaurants.where((restaurant) {
        final name = restaurant['restaurantName'].toString().toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
      return _buildSearchResults();
    }
    return Container(
      color: AppColors.whiteColor,
    );
  }

  Widget _buildSearchResults() {
    if (_currentResults.isEmpty) {
      return Center(
        child: Text(
          "No restaurants found matching '$query'",
          style: AppTextStyles.bodyStyle.copyWith(color: AppColors.whiteColor),
        ),
      );
    } else {
      return Container(
        color: AppColors.whiteColor,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          itemCount: _currentResults.length,
          itemBuilder: (context, index) {
            var restaurant = _currentResults[index];
            return RestaurantCard(restaurant: restaurant);
          },
        ),
      );
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyles.bodyStyle
            .copyWith(color: AppColors.textColor.withCustomOpacity(0.5)),
      ),
    );
  }
}
