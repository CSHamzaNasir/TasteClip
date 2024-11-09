import 'package:flutter/material.dart';

import 'package:tasteclip/constant/app_colors.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  'https://media.istockphoto.com/id/1364917563/photo/businessman-smiling-with-arms-crossed-on-white-background.jpg?s=612x612&w=0&k=20&c=NtM9Wbs1DBiGaiowsxJY6wNCnLf0POa65rYEwnZymrM=',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: AppColors.textColor.withOpacity(.50),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.mainColor, // Starting color
                    AppColors.textColor, // Ending color
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Add other widgets here if needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
