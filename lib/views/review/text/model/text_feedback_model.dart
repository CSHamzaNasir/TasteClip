class FeedbackModel {
  final String userId;
  final String feedbackText;
  final String rating;
  final DateTime createdAt;

  FeedbackModel({
    required this.userId,
    required this.feedbackText,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'feedback_text': feedbackText,
      'rating': rating,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
