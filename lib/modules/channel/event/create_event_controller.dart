import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:tasteclip/modules/channel/event/model/event_model.dart';

class EventController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final discountController = TextEditingController();
  final worthController = TextEditingController();
  final expireDateController = TextEditingController();
  final startDateController = TextEditingController();
  final eventNameController = TextEditingController();
  final eventLocationController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final event = <EventModel>[].obs;
  final selectedImagePath = ''.obs;

  String get userId => _auth.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    tz.initializeTimeZones();
    fetchEvents();
    setupAutoDeleteListener();
  }

  @override
  void onClose() {
    discountController.dispose();
    worthController.dispose();
    expireDateController.dispose();
    startDateController.dispose();
    eventNameController.dispose();
    eventLocationController.dispose();
    eventDescriptionController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.onClose();
  }

  bool validateFields() {
    return eventNameController.text.isNotEmpty &&
        eventLocationController.text.isNotEmpty &&
        eventDescriptionController.text.isNotEmpty &&
        startDateController.text.isNotEmpty &&
        startTimeController.text.isNotEmpty &&
        expireDateController.text.isNotEmpty &&
        endTimeController.text.isNotEmpty &&
        discountController.text.isNotEmpty &&
        worthController.text.isNotEmpty;
  }

  Future<void> createEventWithVoucher() async {
    try {
      isLoading.value = true;

      final user = _auth.currentUser;
      if (user == null) throw "User not authenticated";

      final restaurantData = await _findRestaurantAndBranch(user.uid);
      if (restaurantData == null) throw "Restaurant or branch not found";

      String imageUrl = '';
      if (selectedImagePath.value.isNotEmpty) {
        imageUrl = await _uploadImage(selectedImagePath.value);
      }

      final startDate =
          DateFormat('yyyy-MM-dd').parse(startDateController.text);
      final startTime = _parseTime(startTimeController.text);
      final endDate = DateFormat('yyyy-MM-dd').parse(expireDateController.text);
      final endTime = _parseTime(endTimeController.text);

      final startDateTime = DateTime(
        startDate.year,
        startDate.month,
        startDate.day,
        startTime.hour,
        startTime.minute,
      );

      final endDateTime = DateTime(
        endDate.year,
        endDate.month,
        endDate.day,
        endTime.hour,
        endTime.minute,
      );

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
        startTime: startDateTime,
        endTime: endDateTime,
        interestedUsers: {},
      );

      final docRef = await _firestore.collection('events').add(event.toMap());

      await _scheduleAutoDelete(docRef.id, endDateTime);

      Get.back();
      Get.snackbar(
        'Success',
        'Event created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> _uploadImage(String imagePath) async {
    final File imageFile = File(imagePath);
    final String fileName =
        'event_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final Reference storageRef = _storage.ref().child(fileName);
    final UploadTask uploadTask = storageRef.putFile(imageFile);
    final TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  TimeOfDay _parseTime(String time) {
    try {
      if (time.contains(RegExp(r'^\d{1,2}:\d{2}$'))) {
        final parts = time.split(':');
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }

      final format = DateFormat.jm();
      final dateTime = format.parse(time);
      return TimeOfDay.fromDateTime(dateTime);
    } catch (e) {
      return TimeOfDay.now();
    }
  }

  Future<void> _scheduleAutoDelete(String docId, DateTime endDateTime) async {
    await _firestore.collection('scheduled_deletes').add({
      'eventId': docId,
      'deleteAt': endDateTime,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  void setupAutoDeleteListener() {
    _firestore
        .collection('events')
        .where('endTime', isLessThan: DateTime.now())
        .snapshots()
        .listen((snapshot) {
      for (final doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
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

  Future<void> fetchEvents() async {
    try {
      isLoading.value = true;

      final currentTimeMillis = DateTime.now().millisecondsSinceEpoch;

      _firestore
          .collection('events')
          .where('endTime', isGreaterThan: currentTimeMillis)
          .snapshots()
          .listen((querySnapshot) {
        log("DEBUG: Filtered query returned ${querySnapshot.docs.length} events");

        final eventsList = <EventModel>[];

        for (var doc in querySnapshot.docs) {
          try {
            final data = doc.data();
            data['id'] = doc.id;
            final eventModel = EventModel.fromMap(data);
            eventsList.add(eventModel);
          } catch (e) {
            log("DEBUG: Error parsing event document ${doc.id}: $e");
          }
        }

        event.assignAll(eventsList);
      });
    } catch (e) {
      log("DEBUG: Error in fetchEvents: $e");
      Get.snackbar('Error', 'Failed to fetch events: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

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
}
