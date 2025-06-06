import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A simple analog-style tuning dial.
/// [cents] should be in the range -50..50 representing pitch deviation.
class TuningDial extends StatefulWidget {
  final double cents;
  const TuningDial({super.key, required this.cents});

  @override
  State<TuningDial> createState() => _TuningDialState();
}

class _TuningDialState extends State<TuningDial>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void didUpdateWidget(covariant TuningDial oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When pitch is nearly in tune, show a pulsing glow.
    if (widget.cents.abs() < 3) {
      if (!_controller.isAnimating) {
        _controller.repeat(reverse: true);
      }
    } else {
      _controller.stop();
      _controller.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (widget.cents.abs() < 3)
                BoxShadow(
                  color: Colors.green.withOpacity(0.6 * _controller.value),
                  blurRadius: 20 * _controller.value + 10,
                  spreadRadius: 2 * _controller.value,
                ),
            ],
          ),
          child: CustomPaint(
            painter: _DialPainter(widget.cents),
          ),
        );
      },
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

    final circlePaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, radius, circlePaint);

    // Draw scale marks.
    final markPaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 2;
    for (int i = -5; i <= 5; i++) {
      final angle = (i / 10) * math.pi + math.pi / 2;
      final start = Offset(center.dx + radius * 0.8 * math.cos(angle),
          center.dy + radius * 0.8 * math.sin(angle));
      final end = Offset(center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle));
      canvas.drawLine(start, end, markPaint);
    }

    // Draw indicator needle.
    final indicatorPaint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final clamped = cents.clamp(-50, 50) as double;
    final angle = (clamped / 100) * math.pi + math.pi / 2;
    final end = Offset(center.dx + radius * 0.75 * math.cos(angle),
        center.dy + radius * 0.75 * math.sin(angle));
    canvas.drawLine(center, end, indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) =>
      oldDelegate.cents != cents;
}
