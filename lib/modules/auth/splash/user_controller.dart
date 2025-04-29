import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  var userName = "".obs;
  var userEmail = "".obs;
  var userProfileImage = "".obs;
  var fullName = "".obs;
  var isUserLoaded = false.obs;
  var currentUserId = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData().then((_) {
      if (currentUserId.value.isNotEmpty) {
        fetchAndStoreUserData(currentUserId.value);
      }
    });
  }

  Future<void> fetchAndStoreUserData(String userId) async {
    try {
      // Clear existing data first
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('fullName');
      await prefs.remove('userName');
      await prefs.remove('userEmail');
      await prefs.remove('userProfileImage');
      await prefs.remove('currentUserId');

      currentUserId.value = userId;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('email_user')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        fullName.value = userData['fullName'] ?? '';
        userEmail.value = userData['email'] ?? '';
        userName.value = userData['userName'] ?? '';
        userProfileImage.value = userData['profileImage'] ?? '';

        await prefs.setString('fullName', fullName.value);
        await prefs.setString('userName', userName.value);
        await prefs.setString('userEmail', userEmail.value);
        await prefs.setString('userProfileImage', userProfileImage.value);
        await prefs.setString('currentUserId', currentUserId.value);

        isUserLoaded.value = true;
        log("User Data Fetched & Stored Locally: ${userName.value}");
      }
    } catch (e) {
      log("Error fetching user data: $e");
    }
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullName.value = prefs.getString('fullName') ?? "fullName";
    userName.value = prefs.getString('userName') ?? "Guest User";
    userEmail.value = prefs.getString('userEmail') ?? "No Email";
    userProfileImage.value = prefs.getString('userProfileImage') ?? "";
    currentUserId.value =
        prefs.getString('currentUserId') ?? ""; // Load user ID
    isUserLoaded.value = true;
  }
}
