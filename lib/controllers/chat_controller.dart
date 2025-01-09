import 'package:ai_chatbot/models/message.dart';
import 'package:ai_chatbot/models/open_ai_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final OpenAIModel _aiService = OpenAIModel();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var currentChatId = '';
  var userPrompt = "".obs;
  var messages = [].obs;
  var chats = [].obs;

  Future<void> onSend() async {
    if (textController.text.isNotEmpty) {
      textController.clear();

      messages.add(Message(
        sentBy: 'user',
        message: userPrompt.value,
        dateTime: DateTime.now(),
      ));

      final aiMessage = Message(
        sentBy: "ai",
        dateTime: DateTime.now(),
      );

      messages.add(aiMessage);

      String? response = await _aiService.generateResponse(userPrompt.value);
      userPrompt.value = "";
      aiMessage.message.value = response;

      if (messages.isNotEmpty) {
        if (chats.isNotEmpty &&
            chats.any((chat) => chat.chatId == currentChatId)) {
          var chat = chats.where((chat) => chat.chatId == currentChatId);
          chat.first.messages = messages.value;
          chat.first.lastUpdated = DateTime.now();
        } else {
          final chatId = DateTime.now().toIso8601String();
          currentChatId = chatId;
          chats.add(Chat(
            chatId: chatId,
            title: messages.first.message.value ?? "New Chat",
            lastUpdated: DateTime.now(),
            messages: List.from(messages),
          ));
        }
      }
    } else {
      for (var i = 0; i < messages.length; i++) {
        debugPrint(i.toString());
      }
    }
  }
}
