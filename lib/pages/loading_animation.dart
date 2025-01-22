import 'package:ai_chatbot/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find();

    return Obx(() => Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
                width: 100,
                height: 100,
                'assets/loading/background/bg-${chatController.currentFrame.toString().padLeft(2, '0')}.svg'),
            SvgPicture.asset(
                width: 100,
                height: 100,
                'assets/alternateFrames/star-${chatController.currentFrame.toString().padLeft(2, '0')}.svg'),
          ],
        ));
  }
}
