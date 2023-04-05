import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 4 * size.height / 5);
    Offset curveponit1 = Offset(size.width / 4, size.height);
    Offset centerponit = Offset(size.width / 2, 4 * size.height / 5);
    path.quadraticBezierTo(
      curveponit1.dx,
      curveponit1.dy,
      centerponit.dx,
      centerponit.dy,
    );
    Offset curveponit2 = Offset(3 * size.width / 4, 3 * size.height / 5);
    Offset endponit = Offset(size.width, 4 * size.height / 5);
    path.quadraticBezierTo(
      curveponit2.dx,
      curveponit2.dy,
      endponit.dx,
      endponit.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
