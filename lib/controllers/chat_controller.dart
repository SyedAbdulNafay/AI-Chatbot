import 'package:ai_chatbot/models/message.dart';
import 'package:ai_chatbot/models/open_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final OpenAIModel _aiService = OpenAIModel();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  var userPrompt = "".obs;
  var messages = [].obs;

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
    } else {
      for (var i = 0; i < messages.length; i++) {
        debugPrint(messages[i].message.value.toString());
      }
    }
  }
}
