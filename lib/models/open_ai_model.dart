import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

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

  Stream<String> generateResponseStream(
    String prompt, List<Map<String, String>> context) async* {
  // Convert chat history to Gemini API format
  List<Map<String, dynamic>> formattedHistory = [];

  for (var message in context) {
    if (message['content'] != null && message['content']!.isNotEmpty) {
      formattedHistory.add({
        "role": message['role'] == "user" ? "user" : "model",
        "parts": [
          {"text": message['content']!}
        ]
      });
    }
  }

  // Append the latest user message
  formattedHistory.add({
    "role": "user",
    "parts": [
      {"text": prompt}
    ]
  });

  // Limit the context (e.g., last 10 messages)
  if (formattedHistory.length > 10) {
    formattedHistory = formattedHistory.sublist(formattedHistory.length - 10);
  }

  final requestBody = {
    "contents": formattedHistory
  };

  final response = await http.post(
    Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro:generateContent?key=$apiKey"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    yield data["candidates"][0]["content"]["parts"][0]["text"];
  } else {
    debugPrint("Error ${response.statusCode}: ${response.body}");
  }
}
}
