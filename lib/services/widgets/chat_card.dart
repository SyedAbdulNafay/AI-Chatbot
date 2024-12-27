import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/layout_controller.dart';

class ChatCard extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String chatTitle;
  final String content;
  final String time;
  const ChatCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.chatTitle,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();

    return Container(
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
            chatTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Get.theme.colorScheme.primary,
                fontFamily: 'SecondHeadingFont',
                fontSize: 16),
          ),
          SizedBox(height: layoutController.responsiveHeight(12, screenHeight)),
          Text(
            content,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Get.theme.colorScheme.tertiary,
              fontSize: 16,
            ),
          ),
          SizedBox(height: layoutController.responsiveHeight(12, screenHeight)),
          Text(
            time,
            style: TextStyle(
              color: Get.theme.colorScheme.tertiary,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
