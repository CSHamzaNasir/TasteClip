import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class WatchFeedbackController extends GetxController {
  var feedbackList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedback();
  }

  Future<void> fetchFeedback() async {
    try {
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      List<Map<String, dynamic>> allFeedback = [];

      for (var restaurantDoc in restaurantQuery.docs) {
        List<dynamic> branches = restaurantDoc['branches'] ?? [];
        for (var branch in branches) {
          List<dynamic> feedbacks = branch['imageFeedback'] ?? [];
          for (var feedback in feedbacks) {
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
              "image_url": feedback['image_url'],
              "rating": feedback['rating'].toString(),
              "created_at": formattedTime,
            });
          }
        }
      }
      feedbackList.assignAll(allFeedback);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch feedback: $e");
    }
  }
}
