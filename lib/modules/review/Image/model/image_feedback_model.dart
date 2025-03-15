import 'dart:convert';

class ImageFeedbackModel {
  final String userId;
  final String imageTitle;
  final String description;
  final String rating;
  final List<String> tags;
  final String mealType;
  final String imageUrl;
  final DateTime createdAt;

  ImageFeedbackModel({
    required this.userId,
    required this.imageTitle,
    required this.description,
    required this.rating,
    required this.tags,
    required this.mealType,
    required this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'image_title': imageTitle,
      'description': description,
      'rating': rating,
      'tags': tags,
      'meal_type': mealType,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ImageFeedbackModel.fromMap(Map<String, dynamic> map) {
    return ImageFeedbackModel(
      userId: map['user_id'],
      imageTitle: map['image_title'],
      description: map['description'],
      rating: map['rating'],
      tags: List<String>.from(map['tags']),
      mealType: map['meal_type'],
      imageUrl: map['image_url'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageFeedbackModel.fromJson(String source) =>
      ImageFeedbackModel.fromMap(json.decode(source));
}
