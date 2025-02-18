import 'package:flutter/material.dart';

class BottomSheetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cornerRadius = 36;

    final Path path = Path();
    path.moveTo(cornerRadius, 0);
    path.lineTo((size.width / 2) - 61.5, 0);

    path.quadraticBezierTo(
      (size.width / 2) - 50,
      0,
      (size.width / 2) - 41.5,
      8,
    );
    path.quadraticBezierTo(
      (size.width / 2) - 32.5,
      16,
      (size.width / 2) - 21,
      16,
    );

    path.lineTo((size.width / 2) + 21, 16);

    path.quadraticBezierTo(
      (size.width / 2) + 32.5,
      16,
      (size.width / 2) + 41.5,
      8,
    );
    path.quadraticBezierTo(
      (size.width / 2) + 50,
      0,
      (size.width / 2) + 61.5,
      0,
    );

    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(
      size.width,
      0,
      size.width,
      size.height,
    );
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      0,
      0,
      cornerRadius,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
