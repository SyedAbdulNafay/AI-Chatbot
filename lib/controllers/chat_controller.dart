import 'package:ai_chatbot/models/open_ai_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final OpenAIModel _aiService = OpenAIModel();
  final TextEditingController textController = TextEditingController();
  var userPrompt = "".obs;
  var messages = {"user": [].obs, "ai": [].obs};

  Future<void> onSend() async {
    if (textController.text.isNotEmpty) {
      textController.clear();
      messages['user']!.add(userPrompt.value);
      String? response = await _aiService.generateResponse(userPrompt.value);
      messages['ai']!.add(response);
      userPrompt.value = "";
    } else {
      debugPrint(messages.toString());
    }
  }
}
