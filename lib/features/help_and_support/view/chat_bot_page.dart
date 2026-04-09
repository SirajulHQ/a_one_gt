import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Add welcome message
    _addBotMessage(
      "Hello! I'm your A One GT assistant. How can I help you today?",
    );
    _addQuickReplies();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addBotMessage(String message) {
    setState(() {
      _messages.add(
        ChatMessage(message: message, isUser: false, timestamp: DateTime.now()),
      );
    });
    _scrollToBottom();
  }

  void _addUserMessage(String message) {
    setState(() {
      _messages.add(
        ChatMessage(message: message, isUser: true, timestamp: DateTime.now()),
      );
    });
    _scrollToBottom();
    _handleUserMessage(message);
  }

  void _addQuickReplies() {
    setState(() {
      _messages.add(
        ChatMessage(
          message: "",
          isUser: false,
          timestamp: DateTime.now(),
          isQuickReply: true,
          quickReplies: [
            "Track my order",
            "Return policy",
            "Payment issues",
            "Account help",
          ],
        ),
      );
    });
  }

  void _handleUserMessage(String message) {
    // Simulate bot response delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      String botResponse = _getBotResponse(message.toLowerCase());
      _addBotMessage(botResponse);
    });
  }

  String _getBotResponse(String userMessage) {
    if (userMessage.contains("track") || userMessage.contains("order")) {
      return "To track your order, go to 'My Orders' section in the app. You'll find real-time updates on your order status there.";
    } else if (userMessage.contains("return") ||
        userMessage.contains("refund")) {
      return "Our return policy allows returns within 7 days of delivery. Items must be in original condition. You can initiate a return from the 'My Orders' section.";
    } else if (userMessage.contains("payment") || userMessage.contains("pay")) {
      return "We accept various payment methods including cards, UPI, and cash on delivery. If you're facing payment issues, please try a different payment method or contact our support team.";
    } else if (userMessage.contains("account") ||
        userMessage.contains("profile")) {
      return "You can manage your account from the Settings page. There you can update your profile, addresses, and preferences.";
    } else if (userMessage.contains("delivery") ||
        userMessage.contains("shipping")) {
      return "We offer same-day delivery in most areas. Delivery charges may apply based on your location and order value.";
    } else if (userMessage.contains("hello") || userMessage.contains("hi")) {
      return "Hello! How can I assist you with your A One GT experience today?";
    } else {
      return "I understand you need help with that. For more specific assistance, you can contact our live support team or call us at +971 50 123 4567.";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _addUserMessage(message);
      _messageController.clear();
      HapticFeedback.selectionClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: const CustomAppBar(title: "Chat with Bot"),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message.isQuickReply) {
                  return _buildQuickReplies(message.quickReplies);
                }
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Appcolors.background,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Appcolors.primaryGreen,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Appcolors.primaryGreen.withValues(alpha: 0.1),
              child: Icon(
                Icons.smart_toy_rounded,
                size: 18,
                color: Appcolors.primaryGreen,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? Appcolors.primaryGreen : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Appcolors.primaryGreen,
              child: const Icon(
                Icons.person_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickReplies(List<String> replies) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick replies:",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: replies.map((reply) {
              return GestureDetector(
                onTap: () {
                  _addUserMessage(reply);
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Appcolors.primaryGreen.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    reply,
                    style: TextStyle(
                      color: Appcolors.primaryGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final bool isQuickReply;
  final List<String> quickReplies;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.isQuickReply = false,
    this.quickReplies = const [],
  });
}
