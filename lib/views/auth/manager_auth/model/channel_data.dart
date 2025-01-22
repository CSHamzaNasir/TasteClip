// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChannelDataModel {
  String restaurantId;
  String branchId;
  String restaurantName;
  String branchAddress;
  String branchEmail;
  String restaurantThumb;
  int status;
  DateTime? createdAt;

  ChannelDataModel({
    required this.restaurantId,
    required this.branchId,
    required this.restaurantName,
    required this.branchAddress,
    required this.branchEmail,
    required this.restaurantThumb,
    this.status = 0,
    this.createdAt,
  });

  ChannelDataModel copyWith({
    String? restaurantId,
    String? branchId,
    String? restaurantName,
    String? branchAddress,
    String? branchEmail,
    String? restaurantThumb,
    int? status,
    DateTime? createdAt,
  }) {
    return ChannelDataModel(
      restaurantId: restaurantId ?? this.restaurantId,
      branchId: branchId ?? this.branchId,
      restaurantName: restaurantName ?? this.restaurantName,
      branchAddress: branchAddress ?? this.branchAddress,
      branchEmail: branchEmail ?? this.branchEmail,
      restaurantThumb: restaurantThumb ?? this.restaurantThumb,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurantId': restaurantId,
      'branchId': branchId,
      'restaurantName': restaurantName,
      'branchAddress': branchAddress,
      'branchEmail': branchEmail,
      'restaurantThumb': restaurantThumb,
      'status': status,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory ChannelDataModel.fromMap(Map<String, dynamic> map) {
    return ChannelDataModel(
      restaurantId: map['restaurantId'] as String,
      branchId: map['branchId'] as String,
      restaurantName: map['restaurantName'] as String,
      branchAddress: map['branchAddress'] as String,
      branchEmail: map['branchEmail'] as String,
      restaurantThumb: map['restaurantThumb'] as String,
      status: map['status'] as int,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelDataModel.fromJson(String source) =>
      ChannelDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChannelDataModel(restaurantId: $restaurantId, branchId: $branchId, restaurantName: $restaurantName, branchAddress: $branchAddress, branchEmail: $branchEmail, restaurantThumb: $restaurantThumb, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ChannelDataModel other) {
    if (identical(this, other)) return true;

    return other.restaurantId == restaurantId &&
        other.branchId == branchId &&
        other.restaurantName == restaurantName &&
        other.branchAddress == branchAddress &&
        other.branchEmail == branchEmail &&
        other.restaurantThumb == restaurantThumb &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return restaurantId.hashCode ^
        branchId.hashCode ^
        restaurantName.hashCode ^
        branchAddress.hashCode ^
        branchEmail.hashCode ^
        restaurantThumb.hashCode ^
        status.hashCode ^
        createdAt.hashCode;
  }
}
