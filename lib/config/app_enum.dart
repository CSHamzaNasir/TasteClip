enum UserRole {
  user,
  manager,
}

enum FeedbackCategory {
  image,
  text,
  video,
}

enum FeedbackScope {
  branchFeedback,
  allFeedback,
}

extension FeedbackCategoryExtension on FeedbackCategory {
  String get firestoreValue {
    switch (this) {
      case FeedbackCategory.text:
        return 'text_feedback';
      case FeedbackCategory.image:
        return 'image_feedback';
      case FeedbackCategory.video:
        return 'video_feedback';
    }
  }
}

enum FeedImageStoryHome{
  yes,
  no,
}