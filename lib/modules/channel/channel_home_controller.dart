import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/utils/app_alert.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChannelHomeController extends GetxController {
  final List<Map<String, String>> mealCategories = [
    {"image": "assets/images/breakfast.png", "title": "Breakfast"},
    {"image": "assets/images/lunch.png", "title": "Lunch"},
    {"image": "assets/images/dinner.png", "title": "Dinner"},
  ];
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var managerData = Rxn<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchManagerData();
    fetchBranchFeedback();
  }

  Future<void> fetchManagerData() async {
    try {
      User? user = auth.currentUser;
      if (user == null) return;

      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (var branch in branches) {
          if (branch['branchId'] == user.uid) {
            managerData.value = {
              'restaurantName': doc.id,
              'branchEmail': branch['branchEmail'],
              'branchAddress': branch['branchAddress'],
              'status': branch['status'],
            };
            isLoading.value = false;
            return;
          }
        }
      }
      isLoading.value = false;
      AppAlerts.showSnackbar(
        isSuccess: false,
        message: "Manager data not found. Please contact support.",
      );
    } catch (e) {
      isLoading.value = false;
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    }
  }
  //fetch branch images feedback

  var feedbackList = <Map<String, dynamic>>[].obs;

  Future<void> fetchBranchFeedback() async {
    try {
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      List<Map<String, dynamic>> allFeedback = [];

      for (var restaurantDoc in restaurantQuery.docs) {
        List<dynamic> branches = restaurantDoc['branches'] ?? [];

        for (var branch in branches) {
          if (branch.containsKey('imageFeedback')) {
            List<dynamic> feedbacks = branch['imageFeedback'];

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
      }
      feedbackList.assignAll(allFeedback);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch feedback: $e");
    }
  }
}
