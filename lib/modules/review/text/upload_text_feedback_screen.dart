import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/modules/review/upload_feedback_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/app_feild.dart';
import '../../../widgets/custom_appbar.dart';

// ignore: must_be_immutable
class UploadTextFeedbackScreen extends StatelessWidget {
  UploadTextFeedbackScreen({super.key});
  final controller = Get.put(UploadFeedbackController());

  void _showBottomSheetResturent(BuildContext context) {
    int? selectedRestaurantIndex;

    // Sample list of restaurants
    List<String> restaurantNames = [
      'Restaurant Name',
      'Restaurant Name',
      'Restaurant Name',
      'Restaurant Name',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // This allows controlling the size of the bottom sheet
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  // Make the content scrollable
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppString.selectresturent,
                        style: AppTextStyles.semiBoldStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                      10.vertical,
                      Text(
                        AppString.selectresturentdesc,
                        style: AppTextStyles.thinStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      20.vertical,
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: restaurantNames
                            .length, // Use the length of the restaurant list
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 8.0), // Space between items
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                // Border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // Border radius
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              title: Text(restaurantNames[index],
                                  style: AppTextStyles.thinStyle.copyWith(
                                      color: AppColors
                                          .primaryColor)), // Show the restaurant name
                              trailing: Radio<int>(
                                value: index,
                                groupValue: selectedRestaurantIndex,
                                onChanged: (value) {
                                  setState(() {
                                    selectedRestaurantIndex = value;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      if (selectedRestaurantIndex != null)
                        Column(
                          children: [
                            AppButton(
                              text: 'Next',
                              onPressed: () => _showBottomSheetBranch(context),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBottomSheetBranch(BuildContext context) {
    int? selectedRestaurantIndex;

    // Sample list of restaurants
    List<String> restaurantNames = [
      'Branch Name',
      'Branch Name',
      'Branch Name',
      'Branch Name',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // This allows controlling the size of the bottom sheet
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  // Make the content scrollable
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppString.selectbranch,
                        style: AppTextStyles.semiBoldStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                      10.vertical,
                      Text(
                        AppString.selectresturentdesc,
                        style: AppTextStyles.thinStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      20.vertical,
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: restaurantNames
                            .length, // Use the length of the restaurant list
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 8.0), // Space between items
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                // Border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(8.0), // Border radius
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              title: Text(restaurantNames[index],
                                  style: AppTextStyles.thinStyle.copyWith(
                                      color: AppColors
                                          .primaryColor)), // Show the restaurant name
                              trailing: Radio<int>(
                                value: index,
                                groupValue: selectedRestaurantIndex,
                                onChanged: (value) {
                                  setState(() {
                                    selectedRestaurantIndex = value;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      if (selectedRestaurantIndex != null)
                        Column(
                          children: [
                            AppButton(
                                text: 'Next',
                                onPressed: () =>
                                    _showBottomSheetToughts(context)),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBottomSheetToughts(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // This allows controlling the size of the bottom sheet
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppString.describeyourtought,
                      style: AppTextStyles.semiBoldStyle.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                    10.vertical,
                    Text(
                      AppString.selectresturentdesc,
                      style: AppTextStyles.thinStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    20.vertical,
                    const AppFeild(hintText: 'Enter your feedback here...'),
                    15.vertical,
                    const AppFeild(hintText: 'Select Date'),
                    110.vertical,
                    AppButton(
                      text: 'Submit',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppString.uploadfeedback,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  45.vertical,
                  100.horizontal,
                  Text(
                    AppString.textbasedfeedback,
                    style: AppTextStyles.semiBoldStyle
                        .copyWith(color: AppColors.mainColor),
                  ),
                  23.vertical,
                  Image.asset(AppAssets.textbased),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${AppString.textbasedfeedbackdesc.split(' ').take(2).join(' ')} ',
                                style: AppTextStyles.thinStyle.copyWith(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: AppString.textbasedfeedbackdesc
                                    .split(' ')
                                    .skip(2)
                                    .join(' '),
                                style: AppTextStyles.lightStyle.copyWith(
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        38.vertical,
                        AppButton(
                          text: 'Continue',
                          onPressed: () => _showBottomSheetResturent(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
