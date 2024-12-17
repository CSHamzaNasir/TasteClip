import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantListController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getApprovedManagers() {
    return _firestore
        .collection('manager_credentials')
        .where('status', isEqualTo: 1)
        .snapshots();
  }
}
