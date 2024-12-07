import 'package:ai_chatbot/services/open_ai_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final OpenAIService aiService = OpenAIService();
    final TextEditingController controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(),
            ),
            TextButton(
                onPressed: () async {
                  debugPrint("started");
                  await aiService.generateResponse(controller.text);
                  debugPrint("finished");
                },
                child: Text(
                  "Get response",
                  style: TextStyle(color: Colors.yellow, fontSize: 30),
                ))
          ],
        )),
      ),
    );
  }
}
