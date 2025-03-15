import 'package:get/get.dart';

class RestaurantDetailController extends GetxController {
  var selectedTextIndex = 0.obs;

  void selectText(int index) {
    selectedTextIndex.value = index;
  }

  final List<String> textOptions = [
    "Text",
    "Feedback",
  ];
}
