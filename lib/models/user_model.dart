import 'dart:convert';

class UserModel {
  final String uid;
  final String email;
  final String username;
  final String password;
  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.password,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, username: $username, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        username.hashCode ^
        password.hashCode;
  }
}

// static UserModel empty = UserModel(
//       uid: '', email: '', username: '', about: '', address: '', userImg: '');