import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/layout_controller.dart';

class AuthenButton extends StatelessWidget {
  final bool? disabled;
  final String title;
  final bool? isLoading;
  final double screenHeight;
  final double screenWidth;
  final void Function()? onTap;
  const AuthenButton(
      {super.key,
      required this.screenHeight,
      this.onTap,
      required this.screenWidth,
      this.isLoading,
      required this.title,
      this.disabled});

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
              color: Get.theme.colorScheme.primary
                  .withOpacity(disabled ?? false ? 0.6 : 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: isLoading ?? false
                  ? SizedBox(
                      child: CircularProgressIndicator(
                        color: Get.theme.colorScheme.surface,
                      ),
                    )
                  : Text(
                      title,
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
