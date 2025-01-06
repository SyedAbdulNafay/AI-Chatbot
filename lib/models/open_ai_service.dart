import 'package:google_generative_ai/google_generative_ai.dart';

import '../services/const.dart';

class OpenAIModel {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  Future<String?> generateResponse(String userInput) async {
    final content = [Content.text(userInput)];
    final response = await model.generateContent(content);
    return response.text;
  }
}
