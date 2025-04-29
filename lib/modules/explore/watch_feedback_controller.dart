import 'dart:async';
import 'dart:developer';

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

      feedbacks.value = await Future.wait(
        snapshot.docs.map((doc) => _processFeedbackDocument(doc)),
      );
    } catch (e) {
      log('Failed to fetch branch feedbacks: $e');
      Get.snackbar('Error', 'Failed to fetch branch feedbacks');
    } finally {
      isLoading.value = false;
    }
  }

  Future<UploadFeedbackModel> _processFeedbackDocument(
      QueryDocumentSnapshot doc) async {
    final feedback =
        UploadFeedbackModel.fromMap(doc.data() as Map<String, dynamic>);
    final thumbnail = await _getBranchThumbnail(feedback.branchId);
    return feedback.copyWith(branchThumbnail: thumbnail);
  }

  Future<String?> _getBranchThumbnail(String branchId) async {
    try {
      final querySnapshot = await _firestore
          .collection('restaurants')
          .where('branches.branchId', isEqualTo: branchId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return _extractThumbnailFromDoc(querySnapshot.docs.first, branchId);
      }

      final allRestaurants =
          await _firestore.collection('restaurants').limit(100).get();

      for (final doc in allRestaurants.docs) {
        final thumbnail = _extractThumbnailFromDoc(doc, branchId);
        if (thumbnail != null) return thumbnail;
      }

      return null;
    } catch (e) {
      log('Error fetching branch thumbnail: $e');
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

        final thumbnail = branchMap['branchThumbnail'] as String?;
        if (thumbnail != null) {
          return thumbnail;
        }
      }
      return null;
    } catch (e) {
      log('Error extracting thumbnail: $e');
      return null;
    }
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

      feedbacks.value = await Future.wait(
        snapshot.docs.map((doc) => _processFeedbackDocument(doc)),
      );

      _feedbackSubscription = _firestore
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) async {
        feedbacks.value = await Future.wait(
          snapshot.docs.map((doc) => _processFeedbackDocument(doc)),
        );
        _logTextFeedbackCount();
      });

      isLoading.value = false;
    } catch (e) {
      log('Failed to fetch feedbacks: $e');
      Get.snackbar('Error', 'Failed to fetch feedbacks');
      isLoading.value = false;
    }
  }

  void _logTextFeedbackCount() {
    final currentUserId = _auth.currentUser?.uid;
    if (currentUserId != null) {
      final textFeedbackCount = feedbacks
          .where(
              (f) => f.category == 'text_feedback' && f.userId == currentUserId)
          .length;
      log('Number of text feedbacks by current user: $textFeedbackCount');
    }
  }

  Future<AuthModel?> getUserDetails(String userId) async {
    try {
      final doc = await _firestore.collection('email_user').doc(userId).get();
      if (doc.exists) {
        return AuthModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      log('Error fetching user details: $e');
      return null;
    }
  }

  void updateFeedbackLike(String feedbackId, List<String> newLikes) {
    final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
    if (index != -1) {
      feedbacks[index] = feedbacks[index].copyWith(likes: newLikes);
    }
  }

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

        _updateLocalFeedback(feedbackId, currentLikes, isLiked);
      });
    } catch (e) {
      log('Failed to update like: $e');
      Get.snackbar('Error', 'Failed to update like');
    }
  }

  void _updateLocalFeedback(
      String feedbackId, List<String> likes, bool isLiked) {
    final index = feedbacks.indexWhere((f) => f.feedbackId == feedbackId);
    if (index != -1) {
      final newTasteCoin = isLiked
          ? (feedbacks[index].tasteCoin - 1).clamp(0, 1000000)
          : feedbacks[index].tasteCoin + 1;

      feedbacks[index] = feedbacks[index].copyWith(
        likes: likes,
        tasteCoin: newTasteCoin,
      );
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
      }
    } catch (e) {
      log('Failed to add comment: $e');
      Get.snackbar('Error', 'Failed to add comment');
    }
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
        }
      }
    } catch (e) {
      log('Failed to fetch comments: $e');
    }
  }

  bool isLikedByCurrentUser(UploadFeedbackModel feedback) {
    final currentUserId = _auth.currentUser?.uid;
    return currentUserId != null && feedback.likes.contains(currentUserId);
  }

  Future<void> initializeVideo(String feedbackId, String videoUrl) async {
    if (_videoControllers.containsKey(feedbackId)) return;

    // ignore: deprecated_member_use
    final controller = VideoPlayerController.network(videoUrl);
    _videoControllers[feedbackId] = controller;
    await controller.initialize();
  }

  void toggleVideoPlayback(String feedbackId) {
    final controller = _videoControllers[feedbackId];
    if (controller != null) {
      controller.value.isPlaying ? controller.pause() : controller.play();
    }
  }

  bool isVideoInitialized(String feedbackId) =>
      _videoControllers.containsKey(feedbackId);

  bool isVideoPlaying(String feedbackId) =>
      _videoControllers[feedbackId]?.value.isPlaying ?? false;

  VideoPlayerController? getVideoController(String feedbackId) =>
      _videoControllers[feedbackId];

  String formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  String get currentUserId => _auth.currentUser?.uid ?? '';
}
