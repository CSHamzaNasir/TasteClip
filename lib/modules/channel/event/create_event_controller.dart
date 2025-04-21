import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/modules/channel/event/model/event_model.dart';

class EventController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;
  final discountController = TextEditingController();
  final worthController = TextEditingController();
  final expireDateController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final event = <EventModel>[].obs;

  @override
  void onClose() {
    discountController.dispose();
    worthController.dispose();
    expireDateController.dispose();
    super.onClose();
  }

  Future<void> createVoucher() async {
    try {
      isLoading.value = true;

      final user = _auth.currentUser;
      if (user == null) {
        throw "User not authenticated";
      }

      final restaurantData = await _findRestaurantAndBranch(user.uid);
      if (restaurantData == null) {
        throw "Restaurant or branch not found";
      }

      final voucher = EventModel(
        branchId: restaurantData['branchId'],
        branchName: restaurantData['branchName'],
        branchImage: restaurantData['branchImage'],
        discount: discountController.text.trim(),
        expireDate: expireDateController.text.trim(),
        restaurantName: restaurantData['restaurantName'],
        restaurantId: restaurantData['restaurantId'],
        eventName: '',
        eventLocation: '',
        eventDescription: '',
        // endTime: '',
        // startTime: '',
        interestedUsers: {},
      );

      await _firestore.collection('vouchers').add(voucher.toMap());

      Get.back();
      Get.snackbar('Success', 'Voucher created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVouchers() async {
    try {
      isLoading.value = true;
      final querySnapshot = await _firestore.collection('vouchers').get();

      event.assignAll(querySnapshot.docs.map((doc) {
        return EventModel.fromMap(doc.data());
      }).toList());
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch vouchers: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> _findRestaurantAndBranch(
      String branchId) async {
    final restaurants = await _firestore.collection('restaurants').get();

    for (var restaurantDoc in restaurants.docs) {
      final branches = restaurantDoc['branches'] as List;

      for (var branch in branches) {
        if (branch['branchId'] == branchId) {
          return {
            'branchId': branchId,
            'branchName': branch['branchAddress'] ?? 'Branch',
            'branchImage': branch['branchThumbnail'] ?? '',
            'restaurantName': restaurantDoc['restaurantName'],
            'restaurantId': restaurantDoc.id,
          };
        }
      }
    }
    return null;
  }
}
