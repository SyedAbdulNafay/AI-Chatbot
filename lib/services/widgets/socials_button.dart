import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/layout_controller.dart';

class SocialsButton extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String? filePath;
  final String? title;
  final void Function()? onTap;
  const SocialsButton(
      {super.key,
      this.filePath,
      this.title,
      required this.screenWidth,
      required this.screenHeight,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final LayoutController layoutController = Get.find();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: layoutController.responsiveHeight(20, screenHeight)),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Get.isDarkMode
              ? Get.theme.colorScheme.tertiary
              : Get.theme.colorScheme.outline,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (filePath != null) SvgPicture.asset(filePath!),
              SizedBox(
                  width: layoutController.responsiveWidth(15, screenWidth)),
              if (title != null)
                Text(
                  title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                )
            ],
          ),
        ),
      ),
    );
  }
}
