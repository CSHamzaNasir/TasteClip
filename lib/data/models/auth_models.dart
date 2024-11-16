// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthModel {
  final String uid;
  final String fullName;
  final String userName;
  final String email;
  final String? profileImageUrl;
  AuthModel({
    required this.uid,
    required this.fullName,
    required this.userName,
    required this.email,
    this.profileImageUrl,
  });

  AuthModel copyWith({
    String? uid,
    String? fullName,
    String? userName,
    String? email,
    String? profileImageUrl,
  }) {
    return AuthModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'profileImageUrl': profileImageUrl,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'] as String,
      fullName: map['fullName'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      profileImageUrl: map['profileImageUrl'] != null
          ? map['profileImageUrl'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(uid: $uid, fullName: $fullName, userName: $userName, email: $email, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.fullName == fullName &&
        other.userName == userName &&
        other.email == email &&
        other.profileImageUrl == profileImageUrl;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        profileImageUrl.hashCode;
  }
}
