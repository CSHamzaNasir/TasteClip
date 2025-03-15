import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class WatchFeedbackController extends GetxController {
  var feedbackList = <Map<String, dynamic>>[].obs;
  var feedbackListText = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  var selectedTopFilter = 0.obs;
  var feedback = {}.obs;

  final List<String> categories = ["Text", "Image", "Videos"];
  final List<String> filters = ["All", "BreakFast", "Lunch", "Dinner"];

  void changeCategory(int index) {
    selectedIndex.value = index;
  }

  void changeFilter(int index) {
    selectedTopFilter.value = index;
    fetchImageFeedback();
    fetchFeedbackText();
  }

  @override
  void onInit() {
    super.onInit();
    fetchImageFeedback();
    fetchFeedbackText();
  }

  // Fetch image feedback function with filter
  Future<void> fetchImageFeedback() async {
    try {
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      List<Map<String, dynamic>> allFeedback = [];
      String selectedMealType = filters[selectedTopFilter.value];

      for (var restaurantDoc in restaurantQuery.docs) {
        List<dynamic> branches = restaurantDoc['branches'] ?? [];
        for (var branch in branches) {
          List<dynamic> feedbacks = branch['imageFeedback'] ?? [];
          for (var feedback in feedbacks) {
            String mealType = feedback['meal_type'] ?? "All";

            if (selectedMealType == "All" || mealType == selectedMealType) {
              DateTime createdAt;
              if (feedback['created_at'] is Timestamp) {
                createdAt = (feedback['created_at'] as Timestamp).toDate();
              } else if (feedback['created_at'] is String) {
                createdAt =
                    DateTime.tryParse(feedback['created_at']) ?? DateTime.now();
              } else {
                createdAt = DateTime.now();
              }

              String formattedTime = timeago.format(createdAt);

              allFeedback.add({
                "branch": branch['branchAddress'],
                "channelName": branch['channelName'],
                "branchThumbnail": branch['branchThumbnail'],
                "image_title": feedback['image_title'],
                "description": feedback['description'],
                "image_url": feedback['image_url'],
                "rating": feedback['rating'].toString(),
                "created_at": formattedTime,
                "meal_type": mealType,
              });
            }
          }
        }
      }
      feedbackList.assignAll(allFeedback);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch image feedback: $e");
    }
  }

  // Fetch text feedback function with filter
  Future<void> fetchFeedbackText() async {
    try {
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      List<Map<String, dynamic>> allFeedbackText = [];
      String selectedMealType = filters[selectedTopFilter.value];

      for (var restaurantDoc in restaurantQuery.docs) {
        List<dynamic> branches = restaurantDoc['branches'] ?? [];
        for (var branch in branches) {
          List<dynamic> feedbacksText = branch['textFeedback'] ?? [];
          for (var feedbackText in feedbacksText) {
            String mealType = feedbackText['meal_type'] ?? "All";

            if (selectedMealType == "All" || mealType == selectedMealType) {
              DateTime createdAt;
              if (feedbackText['created_at'] is Timestamp) {
                createdAt = (feedbackText['created_at'] as Timestamp).toDate();
              } else if (feedbackText['created_at'] is String) {
                createdAt = DateTime.tryParse(feedbackText['created_at']) ??
                    DateTime.now();
              } else {
                createdAt = DateTime.now();
              }

              String formattedTime = timeago.format(createdAt);

              allFeedbackText.add({
                "branch": branch['branchAddress'],
                "branchThumbnail": branch['branchThumbnail'],
                "feedback_text": feedbackText['feedback_text'],
                "rating": feedbackText['rating'].toString(),
                "created_at": formattedTime,
                "meal_type": mealType,
              });
            }
          }
        }
      }
      feedbackListText.assignAll(allFeedbackText);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch text feedback: $e");
    }
  }

  void showRestaurantSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16).copyWith(bottom: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Text("Branch Detail",
                    style: AppTextStyles.bodyStyle
                        .copyWith(color: AppColors.mainColor))),
            Row(
              spacing: 16,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: (feedback['branchThumbnail'] != null &&
                          feedback['branchThumbnail'].isNotEmpty)
                      ? NetworkImage(feedback['branchThumbnail'])
                      : null,
                  child: (feedback['branchThumbnail'] == null ||
                          feedback['branchThumbnail'].isEmpty)
                      ? Icon(Icons.image_not_supported, size: 25)
                      : null,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedback['branch'] ?? "No branch",
                      style: AppTextStyles.boldBodyStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      feedback['channelName'] ?? "No Channel Name",
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Text(
              "Total Feedback: 23",
              style: AppTextStyles.bodyStyle.copyWith(
                color: AppColors.textColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryColor),
                color: AppColors.mainColor.withCustomOpacity(.1),
              ),
              child: Row(
                children: [
                  Text(
                    "Channel profile",
                    style: AppTextStyles.bodyStyle.copyWith(
                      fontFamily: AppFonts.sandSemiBold,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    AppAssets.arrowNext,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.mainColor,
                      BlendMode.srcIn,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      isScrollControlled: false,
    );
  }
}
