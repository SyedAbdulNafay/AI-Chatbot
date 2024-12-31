import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: SvgPicture.asset(
          'assets/svgs/send_button_vector.svg',
          colorFilter: ColorFilter.mode(
            Get.theme.colorScheme.tertiary,
            BlendMode.srcIn,
          ),
        ));
  }
}
