import 'package:get/get.dart';

class ChannelHomeController extends GetxController {
  int selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }
}
