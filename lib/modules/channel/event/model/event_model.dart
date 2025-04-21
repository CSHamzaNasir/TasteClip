import 'dart:convert';

import 'package:flutter/foundation.dart';

class EventModel {
  final String branchId;
  final String branchName;
  final String branchImage;
  final String discount;
  final String expireDate;
  final String restaurantName;
  final String restaurantId;
  final String eventName;
  final String eventLocation;
  final String eventDescription;
  final DateTime? endTime;
  final DateTime? startTime;
  final String? id;
  final Map<String, dynamic> interestedUsers;
  EventModel({
    required this.branchId,
    required this.branchName,
    required this.branchImage,
    required this.discount,
    required this.expireDate,
    required this.restaurantName,
    required this.restaurantId,
    required this.eventName,
    required this.eventLocation,
    required this.eventDescription,
    this.endTime,
    this.startTime,
    this.id,
    required this.interestedUsers,
  });

  EventModel copyWith({
    String? branchId,
    String? branchName,
    String? branchImage,
    String? discount,
    String? expireDate,
    String? restaurantName,
    String? restaurantId,
    String? eventName,
    String? eventLocation,
    String? eventDescription,
    DateTime? endTime,
    DateTime? startTime,
    String? id,
    Map<String, dynamic>? interestedUsers,
  }) {
    return EventModel(
      branchId: branchId ?? this.branchId,
      branchName: branchName ?? this.branchName,
      branchImage: branchImage ?? this.branchImage,
      discount: discount ?? this.discount,
      expireDate: expireDate ?? this.expireDate,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantId: restaurantId ?? this.restaurantId,
      eventName: eventName ?? this.eventName,
      eventLocation: eventLocation ?? this.eventLocation,
      eventDescription: eventDescription ?? this.eventDescription,
      endTime: endTime ?? this.endTime,
      startTime: startTime ?? this.startTime,
      id: id ?? this.id,
      interestedUsers: interestedUsers ?? this.interestedUsers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'branchId': branchId,
      'branchName': branchName,
      'branchImage': branchImage,
      'discount': discount,
      'expireDate': expireDate,
      'restaurantName': restaurantName,
      'restaurantId': restaurantId,
      'eventName': eventName,
      'eventLocation': eventLocation,
      'eventDescription': eventDescription,
      'endTime': endTime?.millisecondsSinceEpoch,
      'startTime': startTime?.millisecondsSinceEpoch,
      'id': id,
      'interestedUsers': interestedUsers,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
        branchId: map['branchId'] as String,
        branchName: map['branchName'] as String,
        branchImage: map['branchImage'] as String,
        discount: map['discount'] as String,
        expireDate: map['expireDate'] as String,
        restaurantName: map['restaurantName'] as String,
        restaurantId: map['restaurantId'] as String,
        eventName: map['eventName'] as String,
        eventLocation: map['eventLocation'] as String,
        eventDescription: map['eventDescription'] as String,
        endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int),
        startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int),
        id: map['id'] != null ? map['id'] as String : null,
        interestedUsers: Map<String, dynamic>.from(
          (map['interestedUsers'] as Map<String, dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EventModel(branchId: $branchId, branchName: $branchName, branchImage: $branchImage, discount: $discount, expireDate: $expireDate, restaurantName: $restaurantName, restaurantId: $restaurantId, eventName: $eventName, eventLocation: $eventLocation, eventDescription: $eventDescription, endTime: $endTime, startTime: $startTime, id: $id, interestedUsers: $interestedUsers)';
  }

  @override
  bool operator ==(covariant EventModel other) {
    if (identical(this, other)) return true;

    return other.branchId == branchId &&
        other.branchName == branchName &&
        other.branchImage == branchImage &&
        other.discount == discount &&
        other.expireDate == expireDate &&
        other.restaurantName == restaurantName &&
        other.restaurantId == restaurantId &&
        other.eventName == eventName &&
        other.eventLocation == eventLocation &&
        other.eventDescription == eventDescription &&
        other.endTime == endTime &&
        other.startTime == startTime &&
        other.id == id &&
        mapEquals(other.interestedUsers, interestedUsers);
  }

  @override
  int get hashCode {
    return branchId.hashCode ^
        branchName.hashCode ^
        branchImage.hashCode ^
        discount.hashCode ^
        expireDate.hashCode ^
        restaurantName.hashCode ^
        restaurantId.hashCode ^
        eventName.hashCode ^
        eventLocation.hashCode ^
        eventDescription.hashCode ^
        endTime.hashCode ^
        startTime.hashCode ^
        id.hashCode ^
        interestedUsers.hashCode;
  }
}
