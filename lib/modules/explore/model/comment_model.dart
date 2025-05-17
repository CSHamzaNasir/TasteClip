import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String userId;
  final String userName;
  final String userImage;
  final String comment;
  final DateTime timestamp;
  final List<String> likes;
  final List<String> dislikes;
  final List<CommentModel> replies;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.timestamp,
    this.likes = const [],
    this.dislikes = const [],
    this.replies = const [],
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userImage: map['userImage'] ?? '',
      comment: map['comment'] ?? '',
      timestamp: map['timestamp'] is Timestamp
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.now(),
      likes: List<String>.from(map['likes'] ?? []),
      dislikes: List<String>.from(map['dislikes'] ?? []),
      replies: (map['replies'] as List<dynamic>?)
              ?.map((reply) => CommentModel.fromMap(reply))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'comment': comment,
      'timestamp': timestamp,
      'likes': likes,
      'dislikes': dislikes,
      'replies': replies.map((reply) => reply.toMap()).toList(),
    };
  }
}
