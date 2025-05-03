// ignore_for_file: empty_catches

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';
import 'package:tasteclip/modules/explore/detail/model/comment_model.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:video_player/video_player.dart';

class WatchFeedbackController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxList<UploadFeedbackModel> feedbacks = <UploadFeedbackModel>[].obs;
  final RxBool isLoading = false.obs;

  final Map<String, AuthModel> _userCache = {};

  final Map<String, String?> _thumbnailCache = {};

  final Map<String, VideoPlayerController> _videoControllers = {};

  StreamSubscription<QuerySnapshot>? _feedbackSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchFeedbacks();
  }

  @override
  void onClose() {
    _feedbackSubscription?.cancel();
    _disposeVideoControllers();
    super.onClose();
  }

  void _disposeVideoControllers() {
    for (final controller in _videoControllers.values) {
      controller.dispose();
    }
    _videoControllers.clear();
  }

  Future<void> fetchFeedbacksForBranch(String branchId) async {
    try {
      isLoading.value = true;
      feedbacks.clear();

      final snapshot = await _firestore
          .collection('feedback')
          .where('branchId', isEqualTo: branchId)
          .orderBy('createdAt', descending: true)
          .get();

      final processedFeedbacks = await Future.wait(
        snapshot.docs.map((doc) => _processFeedbackDocument(doc)),
      );

      feedbacks.value = processedFeedbacks;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<UploadFeedbackModel> _processFeedbackDocument(
      QueryDocumentSnapshot doc) async {
    final feedback =
        UploadFeedbackModel.fromMap(doc.data() as Map<String, dynamic>);

    String? thumbnail;
    if (_thumbnailCache.containsKey(feedback.branchId)) {
      thumbnail = _thumbnailCache[feedback.branchId];
    } else {
      thumbnail = await _getBranchThumbnail(feedback.branchId);
      _thumbnailCache[feedback.branchId] = thumbnail;
    }

    return feedback.copyWith(branchThumbnail: thumbnail);
  }

  Future<String?> _getBranchThumbnail(String branchId) async {
    try {
      if (_thumbnailCache.containsKey(branchId)) {
        return _thumbnailCache[branchId];
      }

      final querySnapshot = await _firestore
          .collection('restaurants')
          .where('branches.branchId', isEqualTo: branchId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final thumbnail =
            _extractThumbnailFromDoc(querySnapshot.docs.first, branchId);
        _thumbnailCache[branchId] = thumbnail;
        return thumbnail;
      }

      final allRestaurants =
          await _firestore.collection('restaurants').limit(100).get();

      for (final doc in allRestaurants.docs) {
        final thumbnail = _extractThumbnailFromDoc(doc, branchId);
        if (thumbnail != null) {
          _thumbnailCache[branchId] = thumbnail;
          return thumbnail;
        }
      }

      _thumbnailCache[branchId] = null;
      return null;
    } catch (e) {
      return null;
    }
  }

  String? _extractThumbnailFromDoc(QueryDocumentSnapshot doc, String branchId) {
    try {
      final data = doc.data() as Map<String, dynamic>?;
      if (data == null) return null;

      final branches = data['branches'] as List<dynamic>?;
      if (branches == null) return null;

      for (final branch in branches) {
        if (branch is! Map) continue;

        final branchMap = branch as Map<String, dynamic>;
        if (branchMap['branchId'] != branchId) continue;

        return branchMap['branchThumbnail'] as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Map<String, int> getFeedbackCountsByBranch(String branchId) {
    final branchFeedbacks =
        feedbacks.where((f) => f.branchId == branchId).toList();

    return {
      'text':
          branchFeedbacks.where((f) => f.category == 'text_feedback').length,
      'image':
          branchFeedbacks.where((f) => f.category == 'image_feedback').length,
      'video':
          branchFeedbacks.where((f) => f.category == 'video_feedback').length,
    };
  }

  int getTotalFeedbackCountForBranch(String branchId) {
    return feedbacks.where((f) => f.branchId == branchId).length;
  }

  Future<void> refreshFeedbacks() async {
    await fetchFeedbacks();
  }

  Future<void> fetchFeedbacks() async {
    try {
      isLoading.value = true;
      _feedbackSubscription?.cancel();

      final snapshot = await _firestore
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .limit(100)
          .get();

      final processedFeedbacks = await Future.wait(
        snapshot.docs.map((doc) => _processFeedbackDocument(doc)),
      );

      feedbacks.value = processedFeedbacks;
      isLoading.value = false;

      _feedbackSubscription = _firestore
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) async {
        final updatedFeedbacks = await Future.wait(
          snapshot.docs.map((doc) => _processFeedbackDocument(doc)),
        );
        feedbacks.value = updatedFeedbacks;
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future<AuthModel?> getUserDetails(String userId) async {
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

  Future<void> toggleLike(String feedbackId) async {
    try {
      final currentUserId = _auth.currentUser?.uid;
      if (currentUserId == null) return;

      final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
      if (index == -1) return;

      final currentFeedback = feedbacks[index];
      final isLiked = currentFeedback.likes.contains(currentUserId);
      final newLikes = List<String>.from(currentFeedback.likes);
      final newTasteCoin = isLiked
          ? (currentFeedback.tasteCoin - 1).clamp(0, 1000000)
          : currentFeedback.tasteCoin + 1;

      if (isLiked) {
        newLikes.remove(currentUserId);
      } else {
        newLikes.add(currentUserId);
      }

      feedbacks[index] = currentFeedback.copyWith(
        likes: newLikes,
        tasteCoin: newTasteCoin,
      );
      update();

      final feedbackRef = _firestore.collection('feedback').doc(feedbackId);
      await feedbackRef.update({
        'likes': newLikes,
        'tasteCoin': newTasteCoin,
      });
    } catch (e) {
      final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
      if (index != -1) {
        final currentFeedback = feedbacks[index];
        feedbacks[index] = currentFeedback.copyWith(
          likes: List<String>.from(currentFeedback.likes),
          tasteCoin: currentFeedback.tasteCoin,
        );
        update();
      }
    }
  }

  Future<void> addComment(String feedbackId, String commentText) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      final user = await getUserDetails(currentUser.uid);
      if (user == null) return;

      final commentId = _firestore.collection('comments').doc().id;
      final newComment = CommentModel(
        commentId: commentId,
        userId: currentUser.uid,
        userName: user.fullName,
        userImage: user.profileImage ?? '',
        comment: commentText,
        timestamp: DateTime.now(),
      );

      await _firestore.collection('feedback').doc(feedbackId).update({
        'comments': FieldValue.arrayUnion([newComment.toMap()])
      });

      final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
      if (index != -1) {
        final updatedComments = List<dynamic>.from(feedbacks[index].comments)
          ..add(newComment.toMap());
        feedbacks[index] = feedbacks[index].copyWith(comments: updatedComments);
        update();
      }
    } catch (e) {}
  }

  Future<void> fetchComments(String feedbackId) async {
    try {
      final doc = await _firestore.collection('feedback').doc(feedbackId).get();
      if (doc.exists) {
        final data = doc.data()!;
        final comments = List<dynamic>.from(data['comments'] ?? []);

        final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
        if (index != -1) {
          feedbacks[index] = feedbacks[index].copyWith(comments: comments);
          update();
        }
      }
    } catch (e) {}
  }

  bool isLikedByCurrentUser(UploadFeedbackModel feedback) {
    final currentUserId = _auth.currentUser?.uid;
    return currentUserId != null && feedback.likes.contains(currentUserId);
  }

  Future<void> initializeVideo(String feedbackId, String videoUrl) async {
    if (_videoControllers.containsKey(feedbackId)) return;

    try {
      // ignore: deprecated_member_use
      final controller = VideoPlayerController.network(videoUrl);
      _videoControllers[feedbackId] = controller;
      await controller.initialize();
      update();
    } catch (e) {}
  }

  void toggleVideoPlayback(String feedbackId) {
    final controller = _videoControllers[feedbackId];
    if (controller != null) {
      controller.value.isPlaying ? controller.pause() : controller.play();
      update();
    }
  }

  bool isVideoInitialized(String feedbackId) =>
      _videoControllers.containsKey(feedbackId) &&
      _videoControllers[feedbackId]!.value.isInitialized;

  bool isVideoPlaying(String feedbackId) =>
      _videoControllers[feedbackId]?.value.isPlaying ?? false;

  VideoPlayerController? getVideoController(String feedbackId) =>
      _videoControllers[feedbackId];

  String formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  String get currentUserId => _auth.currentUser?.uid ?? '';
}
