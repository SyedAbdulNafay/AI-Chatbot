import 'package:ai_chatbot/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              text: TextSpan(
                  style: TextStyle(
                    color: Get.theme.colorScheme.inversePrimary,
                    fontSize: 16,
                  ),
                  children: chatController
                      .parseResponse("* ~~strikethrough:~~ text")),
            )
          ],
        ),
      ),
    );
  }
}
