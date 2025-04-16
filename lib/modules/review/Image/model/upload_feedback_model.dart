import 'package:cloud_firestore/cloud_firestore.dart';

class UploadFeedbackModel {
  final String feedbackId;
  final String userId;
  final String restaurantName;
  final String branchName;
  final String description;
  final double rating;
  final String? mediaUrl;
  final String category;
  final DateTime createdAt;
  final List<dynamic> comments;
  final List<String> likes;
  final int tasteCoin;

  UploadFeedbackModel({
    required this.feedbackId,
    required this.userId,
    required this.restaurantName,
    required this.branchName,
    required this.description,
    required this.rating,
    this.mediaUrl,
    required this.category,
    required this.createdAt,
    required this.comments,
    this.likes = const [],
    this.tasteCoin = 0,
  });

  UploadFeedbackModel copyWith({
    String? feedbackId,
    String? userId,
    String? restaurantName,
    String? branchName,
    String? description,
    double? rating,
    String? mediaUrl,
    String? category,
    DateTime? createdAt,
    List<dynamic>? comments,
    List<String>? likes,
    int? tasteCoin,
  }) {
    return UploadFeedbackModel(
      feedbackId: feedbackId ?? this.feedbackId,
      userId: userId ?? this.userId,
      restaurantName: restaurantName ?? this.restaurantName,
      branchName: branchName ?? this.branchName,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
      tasteCoin: tasteCoin ?? this.tasteCoin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feedbackId': feedbackId,
      'userId': userId,
      'restaurantName': restaurantName,
      'branchName': branchName,
      'description': description,
      'rating': rating,
      'mediaUrl': mediaUrl,
      'category': category,
      'createdAt': createdAt,
      'comments': comments,
      'likes': likes,
      'tasteCoin': tasteCoin,
    };
  }

  factory UploadFeedbackModel.fromMap(Map<String, dynamic> map) {
    return UploadFeedbackModel(
      feedbackId: map['feedbackId'] ?? '',
      userId: map['userId'] ?? '',
      restaurantName: map['restaurantName'] ?? '',
      branchName: map['branchName'] ?? '',
      description: map['description'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      mediaUrl: map['mediaUrl'],
      category: map['category'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      comments: List<dynamic>.from(map['comments'] ?? []),
      likes: List<String>.from(map['likes'] ?? []),
      tasteCoin: map['tasteCoin'] ?? 0,
    );
  }
}
