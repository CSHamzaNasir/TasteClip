import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';

class BranchDetailController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var selectedIndexes = <int>[].obs;
  RxList<Map<String, dynamic>> feedbackList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<FeedbackCategory> selectedCategory = FeedbackCategory.text.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllFeedback();
  }

  Future<void> fetchAllFeedback() async {
    try {
      isLoading(true);
      errorMessage('');

      final QuerySnapshot snapshot = await firestore
          .collection('feedback')
          .where('category', isEqualTo: 'text_feedback')
          .orderBy('createdAt', descending: true)
          .get();

      feedbackList.assignAll(snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          ...data,
          'id': doc.id,
        };
      }));
    } catch (e) {
      errorMessage('Failed to load feedback: ${e.toString()}');
      Get.snackbar(
        'Error',
        'Failed to load feedback data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshFeedback() async {
    await fetchAllFeedback();
  }

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

  void filterIconTap(BuildContext context, GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: [
        PopupMenuItem(
          value: FeedbackCategory.text,
          child: ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Text'),
          ),
        ),
        PopupMenuItem(
          value: FeedbackCategory.image,
          child: ListTile(
            leading: Icon(Icons.image),
            title: Text('Image'),
          ),
        ),
        PopupMenuItem(
          value: FeedbackCategory.video,
          child: ListTile(
            leading: Icon(Icons.video_library),
            title: Text('Video'),
          ),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ).then((value) {
      if (value != null) {
        log("Selected: $value");
        selectedCategory(value);
        fetchAllFeedback();
      }
    });
  }
}
