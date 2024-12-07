import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SocialsButton extends StatelessWidget {
  final String filePath;
  final String title;
  const SocialsButton({super.key, required this.filePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 44.5, vertical: 16),
      width: (Get.mediaQuery.size.width - 80) / 2,
      height: 56,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.outline,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(filePath),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
