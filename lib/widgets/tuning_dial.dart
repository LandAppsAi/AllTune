import 'dart:math';
import 'package:flutter/material.dart';

class TuningDial extends StatelessWidget {
  final double cents;

  const TuningDial({Key? key, required this.cents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DialPainter(cents),
      size: const Size(200, 200),
    );
  }
}

class _DialPainter extends CustomPainter {
  final double cents;

  _DialPainter(this.cents);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final ringPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    canvas.drawCircle(center, radius, ringPaint);

    final tickPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;
    for (int i = -5; i <= 5; i++) {
      final angle = pi + (i / 5) * pi;
      final inner = Offset(center.dx + cos(angle) * radius * 0.8,
          center.dy + sin(angle) * radius * 0.8);
      final outer = Offset(center.dx + cos(angle) * radius,
          center.dy + sin(angle) * radius);
      canvas.drawLine(inner, outer, tickPaint);
    }

    final needlePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4;
    final angle = pi + (cents.clamp(-50, 50) / 50) * pi;
    final needle = Offset(center.dx + cos(angle) * radius * 0.75,
        center.dy + sin(angle) * radius * 0.75);
    canvas.drawLine(center, needle, needlePaint);
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) {
    return oldDelegate.cents != cents;
  }
}
