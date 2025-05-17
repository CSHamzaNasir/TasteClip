import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/home/modules/chat_bot/controllers/chat_controller.dart';
import 'package:tasteclip/modules/home/modules/chat_bot/models/chat_model.dart';

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController());
  final ScrollController _scrollController = ScrollController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find best bite',
            style: AppTextStyles.bodyStyle.copyWith(
                color: AppColors.whiteColor, fontFamily: AppFonts.sandBold)),
        backgroundColor: const Color(0xFF6C5CE7),
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C5CE7), Color(0xFFA89BEC)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                });
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: _chatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = _chatController.chatMessages[index];
                    if (index > 0 &&
                        _chatController.chatMessages[index - 1].isUser &&
                        !message.isUser) {
                      return Column(
                        children: [
                          const SizedBox(height: 8),
                          ChatBubble(message: message),
                        ],
                      );
                    }
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
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatefulWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _typingAnimationController;
  bool _showMessage = false;

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (!widget.message.isUser) {
      _typingAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showMessage = true;
          });
        }
      });
      _typingAnimationController.forward();
    } else {
      _showMessage = true;
    }
  }

  @override
  void dispose() {
    _typingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _showMessage
          ? Align(
              alignment: widget.message.isUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                ),
                child: widget.message.isUser
                    ? _buildUserMessage()
                    : _buildBotMessage(),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withCustomOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTypingDot(0),
                      const SizedBox(width: 4),
                      _buildTypingDot(1),
                      const SizedBox(width: 4),
                      _buildTypingDot(2),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedBuilder(
      animation: _typingAnimationController,
      builder: (context, child) {
        final animationValue = _typingAnimationController.value;
        final dotValue = (animationValue * 3 - index).clamp(0.0, 1.0);
        return Opacity(
          opacity: dotValue,
          child: child,
        );
      },
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildUserMessage() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withCustomOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        widget.message.text,
        style: const TextStyle(
          color: Color(0xFF6C5CE7),
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _buildBotMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withCustomOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: widget.message.restaurant != null
              ? _buildRestaurantCard(widget.message.restaurant!)
              : Text(
                  widget.message.text,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                  ),
                ),
        ),
        if (widget.message.restaurant == null)
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              'AI Assistant',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRestaurantCard(Restaurant restaurant) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          restaurant.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF6C5CE7),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              restaurant.location,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star, size: 16, color: Colors.amber[600]),
            const SizedBox(width: 4),
            Text(
              '${restaurant.rating}',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            const SizedBox(width: 12),
            Icon(Icons.restaurant, size: 16, color: Colors.green[600]),
            const SizedBox(width: 4),
            Text(
              restaurant.specialty,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7).withCustomOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '⭐ ${restaurant.highlight}',
            style: TextStyle(
              fontSize: 13,
              color: const Color(0xFF6C5CE7),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}

class CitySelectionWidget extends StatelessWidget {
  final _chatController = Get.put(ChatController());

  final RxString searchQuery = ''.obs;

  CitySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select your city:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6C5CE7)),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search city...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF6C5CE7)),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            onChanged: (value) {
              searchQuery.value = value;
            },
          ),
          SizedBox(
            height: 80,
            child: Obx(() {
              final filteredCities = pakistaniCities.where((city) {
                final query = searchQuery.value.toLowerCase();
                return city.toLowerCase().contains(query);
              }).toList();

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filteredCities.length,
                itemBuilder: (context, index) {
                  final city = filteredCities[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(city),
                      selected: _chatController.selectedCity.value == city,
                      onSelected: (selected) {
                        if (selected) {
                          _chatController.selectCity(city);
                        }
                      },
                      selectedColor: const Color(0xFF6C5CE7),
                      labelStyle: TextStyle(
                        color: _chatController.selectedCity.value == city
                            ? Colors.white
                            : const Color(0xFF6C5CE7),
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFF6C5CE7)),
                      ),
                    ),
                  );
                },
              );
            }),
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
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select food category:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF6C5CE7)),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: foodCategories.map((category) {
              return ChoiceChip(
                label: Text(category),
                selected: _chatController.selectedCategory.value == category,
                onSelected: (selected) {
                  if (selected) {
                    _chatController.selectCategory(category);
                  }
                },
                selectedColor: const Color(0xFF6C5CE7),
                labelStyle: TextStyle(
                  color: _chatController.selectedCategory.value == category
                      ? Colors.white
                      : const Color(0xFF6C5CE7),
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Color(0xFF6C5CE7)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
