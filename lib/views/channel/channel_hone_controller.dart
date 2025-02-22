import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/utils/app_string.dart';

class ChannelHomeController extends GetxController {
  int selectedIndex = 0;
  final List<String> labels = [AppString.videos, "Text", "Images"];

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}
