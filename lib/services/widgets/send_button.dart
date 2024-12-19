import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Get.theme.colorScheme.primary,
      ),
      child: Icon(
        Icons.arrow_circle_up_outlined,
        color: Get.theme.colorScheme.surface,
      ),
    );
  }
}
