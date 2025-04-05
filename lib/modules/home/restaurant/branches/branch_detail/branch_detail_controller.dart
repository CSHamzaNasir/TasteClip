import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:timeago/timeago.dart' as timeago;

class BranchDetailController extends GetxController {
  var selectedIndexes = <int>[].obs;
  var feedbackListText = <Map<String, dynamic>>[].obs;

  final List<String> defaultImages = [
    AppAssets.unDesserets,
    AppAssets.unDrink,
    AppAssets.unMeal,
    AppAssets.unSnack,
    AppAssets.unVeqan,
  ];

  final List<String> selectedImages = [
    AppAssets.deserts,
    AppAssets.drink,
    AppAssets.meal,
    AppAssets.snack,
    AppAssets.veqan,
  ];

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }
    update();
  }

  String getImageForIndex(int index) {
    return selectedIndexes.contains(index)
        ? selectedImages[index]
        : defaultImages[index];
  }

  final List<String> filters = ["All", "Breakfast", "Lunch", "Dinner"];
  var selectedTopFilter = 0.obs;

// In WatchFeedbackController class
  Future<void> fetchFeedbackTextByBranch(String branchName) async {
    try {
      String selectedMealType = filters[selectedTopFilter.value];

      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .where('branchName', isEqualTo: branchName)
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> allFeedbackText = [];

      for (var doc in feedbackQuery.docs) {
        Map<String, dynamic> feedbackData = doc.data() as Map<String, dynamic>;

        if (feedbackData['category'] == "text_feedback" &&
            (selectedMealType == "All" ||
                feedbackData['mealType'] == selectedMealType)) {
          DateTime createdAt = feedbackData['createdAt'].toDate();

          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('email_user')
              .doc(feedbackData['userId'])
              .get();

          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          Map<String, dynamic> feedbackWithUser = {
            "feedbackId": feedbackData['feedbackId'],
            "branch": feedbackData['branchName'],
            "branchThumbnail": feedbackData['branchThumbnail'],
            "review": feedbackData['review'],
            "rating": feedbackData['rating'].toString(),
            "created_at": timeago.format(createdAt),
            "meal_type": feedbackData['mealType'],
            "user_id": feedbackData['userId'],
            "user_fullName": userData['fullName'],
            "user_profileImage": userData['profileImage'],
            "likes": feedbackData['likes'] ?? {},
          };

          allFeedbackText.add(feedbackWithUser);
        }
      }

      feedbackListText.assignAll(allFeedbackText);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch text feedback: $e");
    }
  }
}
