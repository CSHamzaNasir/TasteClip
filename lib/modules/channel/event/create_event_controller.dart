import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/modules/channel/event/model/event_model.dart';

class EventController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final discountController = TextEditingController();
  final worthController = TextEditingController();
  final expireDateController = TextEditingController();
  final eventNameController = TextEditingController();
  final eventLocationController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final event = <EventModel>[].obs;
  final selectedImagePath = ''.obs;

  @override
  void onClose() {
    discountController.dispose();
    worthController.dispose();
    expireDateController.dispose();
    eventNameController.dispose();
    eventLocationController.dispose();
    eventDescriptionController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> toggleInterest(EventModel event) async {
    try {
      isLoading.value = true;

      final query = await _firestore
          .collection('events')
          .where('eventName', isEqualTo: event.eventName)
          .where('restaurantId', isEqualTo: event.restaurantId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return;

      final docId = query.docs.first.id;
      final docRef = _firestore.collection('events').doc(docId);

      if (event.interestedUsers.containsKey(userId)) {
        await docRef.update({
          'interestedUsers.$userId': FieldValue.delete(),
        });
      } else {
        await docRef.update({
          'interestedUsers.$userId': true,
        });
      }

      await fetchEvents();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update interest: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createEventWithVoucher() async {
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

      String imageUrl = '';
      if (selectedImagePath.value.isNotEmpty) {
        final File imageFile = File(selectedImagePath.value);
        final String fileName =
            'event_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
        final Reference storageRef = _storage.ref().child(fileName);
        final UploadTask uploadTask = storageRef.putFile(imageFile);
        final TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
      }

      final event = EventModel(
        branchId: restaurantData['branchId'],
        branchName: restaurantData['branchName'],
        branchImage:
            imageUrl.isNotEmpty ? imageUrl : restaurantData['branchImage'],
        discount: discountController.text.trim(),
        expireDate: expireDateController.text.trim(),
        restaurantName: restaurantData['restaurantName'],
        restaurantId: restaurantData['restaurantId'],
        eventName: eventNameController.text.trim(),
        eventLocation: eventLocationController.text.trim(),
        eventDescription: eventDescriptionController.text.trim(),
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(days: 1)),
        interestedUsers: {},
      );

      await _firestore.collection('events').add(event.toMap());

      Get.back();
      Get.snackbar('Success', 'Event with voucher created successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;
      _firestore.collection('events').snapshots().listen((querySnapshot) {
        event.assignAll(querySnapshot.docs.map((doc) {
          return EventModel.fromMap(doc.data());
        }).toList());
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch events: ${e.toString()}');
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
