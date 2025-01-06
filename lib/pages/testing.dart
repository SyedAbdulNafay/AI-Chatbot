import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/open_ai_service.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    final OpenAIModel aiService = OpenAIModel();
    final TextEditingController controller = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: const Size(300, 300),
              painter: RectPainter(),
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(),
            ),
            TextButton(
                onPressed: () async {
                  debugPrint("started");
                  await aiService.generateResponse(controller.text);
                  debugPrint("finished");
                },
                child: const Text(
                  "Get response",
                  style: TextStyle(color: Colors.yellow, fontSize: 30),
                ))
          ],
        )),
      ),
    );
  }
}

class RectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the rectangle using Rect.fromLTRB(left, top, right, bottom)
    const Rect rect = Rect.fromLTRB(0, 0, 250, 150);

    // Create a gradient to fill the rectangle
    final Gradient gradient = LinearGradient(
        colors: [
          Get.theme.colorScheme.primary,
          Get.theme.colorScheme.secondary,
        ],
        begin: Alignment.bottomLeft, // Start of gradient
        end: Alignment.topRight, // End of gradient
        stops: const [0.3, 1.0]);

    // Create a Paint object with the gradient
    final Paint paint = Paint()..shader = gradient.createShader(rect);

    // Draw the rectangle on the canvas
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
