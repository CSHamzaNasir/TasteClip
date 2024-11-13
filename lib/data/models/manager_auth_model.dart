import 'dart:convert';

class ManagerAuthModel {
  final String uid;
  final String restaurantName;
  final String address;
  final String businessEmail;
  final String passkey;
  ManagerAuthModel({
    required this.uid,
    required this.restaurantName,
    required this.address,
    required this.businessEmail,
    required this.passkey,
  });

  ManagerAuthModel copyWith({
    String? uid,
    String? restaurantName,
    String? address,
    String? businessEmail,
    String? passkey,
  }) {
    return ManagerAuthModel(
      uid: uid ?? this.uid,
      restaurantName: restaurantName ?? this.restaurantName,
      address: address ?? this.address,
      businessEmail: businessEmail ?? this.businessEmail,
      passkey: passkey ?? this.passkey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'restaurantName': restaurantName,
      'address': address,
      'businessEmail': businessEmail,
      'passkey': passkey,
    };
  }

  factory ManagerAuthModel.fromMap(Map<String, dynamic> map) {
    return ManagerAuthModel(
      uid: map['uid'] as String,
      restaurantName: map['restaurantName'] as String,
      address: map['address'] as String,
      businessEmail: map['businessEmail'] as String,
      passkey: map['passkey'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerAuthModel.fromJson(String source) =>
      ManagerAuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ManagerAuthModel(uid: $uid, restaurantName: $restaurantName, address: $address, businessEmail: $businessEmail, passkey: $passkey)';
  }

  @override
  bool operator ==(covariant ManagerAuthModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.restaurantName == restaurantName &&
        other.address == address &&
        other.businessEmail == businessEmail &&
        other.passkey == passkey;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        restaurantName.hashCode ^
        address.hashCode ^
        businessEmail.hashCode ^
        passkey.hashCode;
  }
}
