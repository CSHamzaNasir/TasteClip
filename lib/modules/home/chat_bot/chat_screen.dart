import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/modules/home/chat_bot/chat_controller.dart';
import 'package:tasteclip/modules/home/chat_bot/chat_model.dart';

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController()); 
  final ScrollController _scrollController = ScrollController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pakistani Food Guide'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_scrollController.hasClients) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              });
              return ListView.builder(
                controller: _scrollController,
                itemCount: _chatController.chatMessages.length,
                itemBuilder: (context, index) {
                  final message = _chatController.chatMessages[index];
                  return ChatBubble(message: message);
                },
              );
            }),
          ),
          Obx(() {
            if (_chatController.showCitySelection.value) {
              return CitySelectionWidget();
            } else if (_chatController.showCategorySelection.value) {
              return CategorySelectionWidget();
            } else {
              return UserInputWidget();
            }
          }),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.orange[200] : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(message.isUser ? 12 : 0),
            topRight: Radius.circular(message.isUser ? 0 : 12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: message.restaurant != null
            ? _buildRestaurantCard(message.restaurant!)
            : Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.black : Colors.black87,
                ),
              ),
      ),
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.orange),
            SizedBox(width: 4),
            Text(
              restaurant.location,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber),
            SizedBox(width: 4),
            Text(
              '${restaurant.rating}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(width: 12),
            Icon(Icons.restaurant, size: 16, color: Colors.green),
            SizedBox(width: 4),
            Text(
              restaurant.specialty,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          '⭐ ${restaurant.highlight}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class CitySelectionWidget extends StatelessWidget {
  final _chatController = Get.put(ChatController());

  CitySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(8),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'Select your city:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: pakistaniCities.length,
              itemBuilder: (context, index) {
                final city = pakistaniCities[index];
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _chatController.selectCity(city),
                  child: Text(
                    city,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySelectionWidget extends StatelessWidget {
  final _chatController = Get.put(ChatController());

  CategorySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(8),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'Select food category:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: foodCategories.length,
              itemBuilder: (context, index) {
                final category = foodCategories[index];
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => _chatController.selectCategory(category),
                  child: Text(
                    category,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserInputWidget extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final ChatController _chatController = Get.find();

  UserInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.orange,
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  _chatController.chatMessages.add(ChatMessage(
                    text: _textController.text,
                    isUser: true,
                  ));
                  _textController.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
