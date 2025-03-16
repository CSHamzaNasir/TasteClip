class ImageFeedbackModel {
  final String feedbackId; // Add this field
  final String userId;
  final String imageTitle;
  final String description;
  final String rating;
  final List<String> tags;
  final String mealType;
  final String imageUrl;
  final DateTime createdAt;
  final List<Map<String, dynamic>> comments;

  ImageFeedbackModel({
    required this.feedbackId, // Add this field
    required this.userId,
    required this.imageTitle,
    required this.description,
    required this.rating,
    required this.tags,
    required this.mealType,
    required this.imageUrl,
    required this.createdAt,
    this.comments = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'feedbackId': feedbackId, // Add this field
      'userId': userId,
      'imageTitle': imageTitle,
      'description': description,
      'rating': rating,
      'tags': tags,
      'mealType': mealType,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'comments': comments,
    };
  }

  factory ImageFeedbackModel.fromMap(Map<String, dynamic> data) {
    return ImageFeedbackModel(
      feedbackId: data['feedbackId'], // Add this field
      userId: data['userId'],
      imageTitle: data['imageTitle'],
      description: data['description'],
      rating: data['rating'],
      tags: List<String>.from(data['tags']),
      mealType: data['mealType'],
      imageUrl: data['imageUrl'],
      createdAt: data['createdAt'].toDate(),
      comments: List<Map<String, dynamic>>.from(data['comments'] ?? []),
    );
  }
}
