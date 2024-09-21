import 'dart:convert';

class AuthModel {
  final String uid;
  final String fullName;
  final String userName;
  final String email;
  AuthModel({
    required this.uid,
    required this.fullName,
    required this.userName,
    required this.email,
  });

  AuthModel copyWith({
    String? uid,
    String? fullName,
    String? userName,
    String? email,
  }) {
    return AuthModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'userName': userName,
      'email': email,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      uid: map['uid'] as String,
      fullName: map['fullName'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModels(uid: $uid, fullName: $fullName, userName: $userName, email: $email)';
  }

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.fullName == fullName &&
        other.userName == userName &&
        other.email == email;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        userName.hashCode ^
        email.hashCode;
  }
}
