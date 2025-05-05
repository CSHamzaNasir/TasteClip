import 'dart:convert';

class AuthModel {
  final String uid;
  final String fullName;
  final String userName;
  final String email;
  final String? profileImage;
  final String? fcmToken;

  AuthModel({
    required this.uid,
    required this.fullName,
    required this.userName,
    required this.email,
    this.profileImage,
    this.fcmToken,
  });

  AuthModel copyWith({
    String? uid,
    String? fullName,
    String? userName,
    String? email,
    String? profileImage,
    String? fcmToken,
  }) {
    return AuthModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'fcmToken': fcmToken,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'] as String,
      fullName: map['fullName'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] != null ? map['profileImage'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(uid: $uid, fullName: $fullName, userName: $userName, email: $email, profileImage: $profileImage, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.fullName == fullName &&
        other.userName == userName &&
        other.email == email &&
        other.profileImage == profileImage &&
        other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        profileImage.hashCode ^
        fcmToken.hashCode;
  }
}