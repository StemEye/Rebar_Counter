import 'package:flutter/material.dart';

class RebarPainter extends CustomPainter {
  final List<Offset> rebarPositions;

  // Constructor to accept rebarPositions
  RebarPainter({required this.rebarPositions});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    for (var position in rebarPositions) {
      canvas.drawCircle(
          position, 10, paint); // Draw circle at each rebar position
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
