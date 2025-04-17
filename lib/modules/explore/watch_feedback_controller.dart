import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:video_player/video_player.dart';

class WatchFeedbackController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxList<UploadFeedbackModel> feedbacks = <UploadFeedbackModel>[].obs;
  RxBool isLoading = false.obs;
  final Map<String, VideoPlayerController> _videoControllers = {};
  final Map<String, AuthModel?> _userCache = {};
  final Map<String, String> _branchThumbnailCache = {};

  @override
  void onInit() {
    _preloadBranches();
    fetchFeedbacks();
    super.onInit();
  }

  @override
  void onClose() {
    for (var controller in _videoControllers.values) {
      controller.dispose();
    }
    _videoControllers.clear();
    super.onClose();
  }

  Future<void> _preloadBranches() async {
    try {
      final snapshot = await _firestore
          .collection('restaurants')
          .doc('branches')
          .collection('branches')
          .get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final name = data['branchName'] as String?;
        final thumbnail = data['branchThumbnail'] as String?;
        if (name != null && thumbnail != null) {
          _branchThumbnailCache[name] = thumbnail;
        }
      }
    } catch (e) {
      debugPrint('Error preloading branches: $e');
    }
  }

  Future<void> fetchFeedbacks() async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

      feedbacks.value = snapshot.docs.map((doc) {
        final feedback = UploadFeedbackModel.fromMap(doc.data());
        if (_branchThumbnailCache.containsKey(feedback.branchName)) {
          feedback.branchThumbnail = _branchThumbnailCache[feedback.branchName];
        }
        return feedback;
      }).toList();

      await Future.wait(feedbacks.map((f) => _getUserDetails(f.userId)));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch feedbacks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFeedbacksByCategory(String category) async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore
          .collection('feedback')
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();

      feedbacks.value = snapshot.docs.map((doc) {
        final feedback = UploadFeedbackModel.fromMap(doc.data());
        if (_branchThumbnailCache.containsKey(feedback.branchName)) {
          feedback.branchThumbnail = _branchThumbnailCache[feedback.branchName];
        }
        return feedback;
      }).toList();

      await Future.wait(feedbacks.map((f) => _getUserDetails(f.userId)));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch feedbacks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<AuthModel?> _getUserDetails(String userId) async {
    if (_userCache.containsKey(userId)) {
      return _userCache[userId];
    }

    try {
      final doc = await _firestore.collection('email_user').doc(userId).get();
      if (doc.exists) {
        final user = AuthModel.fromMap(doc.data()!);
        _userCache[userId] = user;
        return user;
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching user details: $e');
      return null;
    }
  }

  void updateFeedbackLike(String feedbackId, List<String> newLikes) {
    final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
    if (index != -1) {
      feedbacks[index] = feedbacks[index].copyWith(likes: newLikes);
      update();
    }
  }

  AuthModel? getUserDetails(String userId) => _userCache[userId];

  Future<void> toggleLike(String feedbackId) async {
    try {
      final currentUserId = _auth.currentUser?.uid;
      if (currentUserId == null) return;

      final feedbackRef = _firestore.collection('feedback').doc(feedbackId);

      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(feedbackRef);
        if (!snapshot.exists) return;

        final data = snapshot.data()!;
        final currentLikes = List<String>.from(data['likes'] ?? []);
        final isLiked = currentLikes.contains(currentUserId);
        final currentTasteCoin = (data['tasteCoin'] as int? ?? 0);

        if (isLiked) {
          currentLikes.remove(currentUserId);
          transaction.update(feedbackRef, {
            'likes': currentLikes,
            'tasteCoin': (currentTasteCoin - 1).clamp(0, 1000000)
          });
        } else {
          currentLikes.add(currentUserId);
          transaction.update(feedbackRef,
              {'likes': currentLikes, 'tasteCoin': currentTasteCoin + 1});
        }

        final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
        if (index != -1) {
          final newTasteCoin = isLiked
              ? (feedbacks[index].tasteCoin - 1).clamp(0, 1000000)
              : feedbacks[index].tasteCoin + 1;

          feedbacks[index] = feedbacks[index].copyWith(
            likes: currentLikes,
            tasteCoin: newTasteCoin,
          );
        }
      });

      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update like: $e');
      debugPrint('Error details: $e');
    }
  }

  bool isLikedByCurrentUser(UploadFeedbackModel feedback) {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) return false;
    return feedback.likes.contains(currentUserId);
  }

  Future<void> initializeVideo(String feedbackId, String videoUrl) async {
    if (_videoControllers.containsKey(feedbackId)) return;

    final controller = VideoPlayerController.network(videoUrl);
    _videoControllers[feedbackId] = controller;
    await controller.initialize();
    update();
  }

  void toggleVideoPlayback(String feedbackId) {
    final controller = _videoControllers[feedbackId];
    if (controller != null) {
      if (controller.value.isPlaying) {
        controller.pause();
      } else {
        controller.play();
      }
      update();
    }
  }

  bool isVideoInitialized(String feedbackId) =>
      _videoControllers.containsKey(feedbackId);

  bool isVideoPlaying(String feedbackId) =>
      _videoControllers[feedbackId]?.value.isPlaying ?? false;

  VideoPlayerController? getVideoController(String feedbackId) =>
      _videoControllers[feedbackId];

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String get currentUserId => _auth.currentUser?.uid ?? '';
}
