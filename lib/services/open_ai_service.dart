import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'const.dart';

class OpenAIService {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  Future<void> generateResponse(String userInput) async {
    final content = [Content.text(userInput)];
    final response = await model.generateContent(content);
    debugPrint(response.text);
  }
}
