enum UserRole {
  user,
  manager,
}

enum FeedbackCategory {
  image,
  text,
  video,
}

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.user:
        return 'user';
      case UserRole.manager:
        return 'manager';
    }
  }
}

enum FeedbackScope {
  branchFeedback,
  allFeedback,
  currentUserFeedback,
  homefeed,
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

enum FeedImageStoryHome {
  yes,
  no,
}

enum ReportStatus {
  pending,
  solved,
}
