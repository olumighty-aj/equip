import 'package:equipro/utils/screensize.dart';
import 'package:flutter/material.dart';
import 'package:equipro/main.dart';

class LineDashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 1..color = Colors.grey;
    var max = 380;
    var dashWidth = 5;
    var dashSpace = 5;
    double startY = 0;
    while (max >= 0) {
      canvas.drawLine(Offset( startY,0), Offset( startY + dashWidth,0), paint,);
      final space = (dashSpace + dashWidth);
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}