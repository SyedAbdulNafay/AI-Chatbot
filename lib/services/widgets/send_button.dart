import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SendButton extends StatelessWidget {
  final bool disabled;
  final void Function()? onTap;
  const SendButton({super.key, this.onTap, required this.disabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                Get.theme.colorScheme.primary.withOpacity(disabled ? 0.75 : 1),
          ),
          child: SvgPicture.asset(
            'assets/svgs/send_button_vector.svg',
            colorFilter: ColorFilter.mode(
              Get.theme.colorScheme.surface,
              BlendMode.srcIn,
            ),
          )),
    );
  }
}
