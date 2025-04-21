import 'package:get/get.dart';
import 'package:tasteclip/modules/home/chat_bot/chat_model.dart';

class Restaurant {
  final String name;
  final String specialty;
  final String location;
  final String highlight;
  final double rating;

  Restaurant({
    required this.name,
    required this.specialty,
    required this.location,
    required this.highlight,
    required this.rating,
  });
}

class ChatMessage {
  final String text;
  final bool isUser;
  final Restaurant? restaurant;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.restaurant,
  });
}

class ChatController extends GetxController {
  var selectedCity = ''.obs;
  var selectedCategory = ''.obs;
  var chatMessages = <ChatMessage>[].obs;
  var showCitySelection = true.obs;
  var showCategorySelection = false.obs;

  @override
  void onInit() {
    super.onInit();
    chatMessages.add(ChatMessage(
      text: 'Welcome to Food Recommendations! Please select your city:',
      isUser: false,
    ));
  }

  void selectCity(String city) {
    selectedCity.value = city;
    chatMessages.add(ChatMessage(
      text: 'You selected: $city',
      isUser: true,
    ));
    chatMessages.add(ChatMessage(
      text: 'Great choice! Now please select a food category:',
      isUser: false,
    ));
    showCitySelection.value = false;
    showCategorySelection.value = true;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    chatMessages.add(ChatMessage(
      text: 'You selected: $category',
      isUser: true,
    ));

    final cityRecos = recommendations[selectedCity.value];
    if (cityRecos != null) {
      final categoryRecos = cityRecos[category];
      if (categoryRecos != null && categoryRecos.isNotEmpty) {
        chatMessages.add(ChatMessage(
          text: 'Here are the top $category spots in ${selectedCity.value}:',
          isUser: false,
        ));
        for (final restaurant in categoryRecos) {
          chatMessages.add(ChatMessage(
            text: restaurant.name,
            isUser: false,
            restaurant: restaurant,
          ));
        }
      } else {
        chatMessages.add(ChatMessage(
          text:
              'No recommendations found for $category in ${selectedCity.value}',
          isUser: false,
        ));
      }
    } else {
      chatMessages.add(ChatMessage(
        text: 'No recommendations available for ${selectedCity.value} yet',
        isUser: false,
      ));
    }

    showCategorySelection.value = false;
  }
}
