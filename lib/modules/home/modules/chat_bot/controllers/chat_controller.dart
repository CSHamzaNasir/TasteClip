import 'package:get/get.dart';
import 'package:tasteclip/modules/home/modules/chat_bot/models/chat_model.dart';

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
  var isTyping = false.obs; // <-- NEW

  @override
  void onInit() {
    super.onInit();
    addBotMessage('Welcome to Food Recommendations! Please select your city:');
  }

  void addBotMessage(String text, {Restaurant? restaurant}) async {
    isTyping.value = true;
    await Future.delayed(Duration(seconds: 1));
    isTyping.value = false;
    chatMessages.add(ChatMessage(
      text: text,
      isUser: false,
      restaurant: restaurant,
    ));
  }

  void selectCity(String city) {
    selectedCity.value = city;
    chatMessages.add(ChatMessage(text: 'You selected: $city', isUser: true));
    addBotMessage('Great choice! Now please select a food category:');
    showCitySelection.value = false;
    showCategorySelection.value = true;
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    chatMessages
        .add(ChatMessage(text: 'You selected: $category', isUser: true));

    final cityRecos = recommendations[selectedCity.value];
    if (cityRecos != null) {
      final categoryRecos = cityRecos[category];
      if (categoryRecos != null && categoryRecos.isNotEmpty) {
        addBotMessage(
            'Here are the top $category spots in ${selectedCity.value}:');
        for (final restaurant in categoryRecos) {
          addBotMessage(restaurant.name, restaurant: restaurant);
        }
      } else {
        addBotMessage(
            'No recommendations found for $category in ${selectedCity.value}');
      }
    } else {
      addBotMessage(
          'No recommendations available for ${selectedCity.value} yet');
    }

    showCategorySelection.value = false;
  }
}
