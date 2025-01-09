import 'package:ai_chatbot/models/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../controllers/layout_controller.dart';

class ChatCard extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Chat chat;
  final void Function()? onTap;
  const ChatCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.chat,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          vertical: layoutController.responsiveHeight(32, screenHeight),
          horizontal: layoutController.responsiveWidth(24, screenWidth),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: Get.theme.colorScheme.tertiary.withOpacity(0.28),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontFamily: 'SecondHeadingFont',
                  fontSize: 16),
            ),
            SizedBox(
                height: layoutController.responsiveHeight(12, screenHeight)),
            Text(
              chat.messages.elementAt(1).message.value ?? "",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Get.theme.colorScheme.tertiary,
                fontSize: 16,
              ),
            ),
            SizedBox(
                height: layoutController.responsiveHeight(12, screenHeight)),
            Text(
              timeago.format(chat.lastUpdated, locale: 'en'),
              style: TextStyle(
                color: Get.theme.colorScheme.tertiary.withOpacity(0.7),
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
