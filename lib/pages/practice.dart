import 'package:ai_chatbot/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                  text: TextSpan(
                      children: chatController.parseResponse(
                          "def add_numbers(num1, num2):\n \"\"\"Adds two numbers and prints their sum. \n Args:\nnum1: The first number.\nnum2: The second number.\n\"\"\"\n  sum_result = num1 + num2\n  print(f\"The sum of {num1} and {num2} is: {sum_result}\")\n\n\n# Get input from the user (optional - you can hardcode values too)\ntry:\n  number1 = float(input(\"Enter the first number: \"))\n  number2 = float(input(\"Enter the second number: \"))\n  add_numbers(number1, number2)\nexcept ValueError:\n  print(\"Invalid input. Please enter numbers only.\")\n\n\n\n# Example of hardcoding values:\n# add_numbers(5, 3)  # Output: The sum of 5 and 3 is: 8\n# add_numbers(10.5, 2.5) # Output: The sum of 10.5 and 2.5 is: 13.0")))
            ],
          ),
        ),
      ),
    );
  }
}
