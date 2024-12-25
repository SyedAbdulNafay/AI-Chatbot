import 'package:ai_chatbot/controllers/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenButton extends StatelessWidget {
  final bool isLoading;
  final double screenHeight;
  final double screenWidth;
  final void Function()? onTap;
  const AuthenButton(
      {super.key,
      required this.screenHeight,
      this.onTap,
      required this.screenWidth,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: layoutController.responsiveWidth(120, screenWidth),
                maxHeight: layoutController.responsiveHeight(70, screenHeight)),
            padding: EdgeInsets.symmetric(
                vertical: layoutController.responsiveHeight(15, screenHeight),
                horizontal: layoutController.responsiveWidth(10, screenWidth)),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      child: CircularProgressIndicator(
                        color: Get.theme.colorScheme.surface,
                      ),
                    )
                  : Text(
                      "Continue",
                      style: TextStyle(
                        color: Get.theme.colorScheme.surface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
