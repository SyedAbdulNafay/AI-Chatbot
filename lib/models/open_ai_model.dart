import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../services/const.dart';

class OpenAIModel {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
  );

  Future<String?> generateResponse(String userInput) async {
    final content = [Content.text(userInput)];
    final response = await model.generateContent(content);
    return response.text;
  }

  Stream<String> generateResponseStream(String userInput) async* {
    final content = [Content.text(userInput)];
    final responseStream = model.generateContentStream(content);

    await for (final response in responseStream) {
      if (response.text == null) {
        throw Exception('Failed to generate response');
      }
      yield response.text!;
    }
  }
}
