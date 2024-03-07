import 'package:drinkup_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RadialProgressPainter extends CustomPainter {
  static const double strokeWidth = 1;
  final double value;
  final List<Color> backgroundGradientColors;
  final double minValue;
  final double maxValue;
  final double scale;
  final Animation<double> animationController;
  final double size;
  late final List<Paint> lateCirclePaints;

  // Constructor to initialize the RadialProgressPainter with required parameters.
  RadialProgressPainter({
    required this.value,
    required this.backgroundGradientColors,
    required this.minValue,
    required this.maxValue,
    required this.animationController,
    this.scale = 1.0,
    this.size = 200.0,
  }) {
    lateCirclePaints = [
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1
        ..strokeCap = StrokeCap.square
        ..shader = SweepGradient(
          colors: <Color>[
            Color.fromARGB(255, 92, 143, 255),
            Color.fromARGB(255, 78, 155, 255),
            Color.fromARGB(255, 50, 87, 255),
          ],
          startAngle: -pi / 2,
          endAngle: 3 * pi / 2,
          tileMode: TileMode.repeated,
        ).createShader(Rect.fromCircle(
            center: Offset(size / 2, size / 2), radius: size / 2)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 2
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          colors: <Color>[
            Color.fromARGB(255, 0, 68, 255),
            Color.fromARGB(255, 15, 11, 233),
            Color.fromARGB(255, 0, 44, 240),
          ],
          startAngle: -pi / 2,
          endAngle: 3 * pi / 2,
          tileMode: TileMode.repeated,
        ).createShader(Rect.fromCircle(
            center: Offset(size / 2, size / 2), radius: size / 2)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 6
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          colors: <Color>[
            Color.fromARGB(255, 9, 0, 134),
            Color.fromARGB(255, 0, 7, 105),
            Color.fromARGB(255, 9, 0, 136),
          ],
          startAngle: -pi / 2,
          endAngle: 3 * pi / 2,
          tileMode: TileMode.repeated,
        ).createShader(Rect.fromCircle(
            center: Offset(size / 2, size / 2), radius: size / 2)),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 9
        ..strokeCap = StrokeCap.round
        ..shader = SweepGradient(
          colors: <Color>[
            Color.fromARGB(255, 83, 229, 255),
            Color.fromARGB(255, 0, 255, 221),
            Color.fromARGB(255, 3, 0, 46)
          ],
          startAngle: -pi / 2,
          endAngle: 3 * pi / 2,
          tileMode: TileMode.repeated,
        ).createShader(Rect.fromCircle(
            center: Offset(size / 2, size / 2), radius: size / 2)),
    ];
  }

  @override
  void paint(Canvas canvas, Size size) {
    // circle's diameter // taking min side as diameter
    final double diameter = min(size.height, size.width);
    // Radius
    final double radius = diameter / 2;
    // Center cordinate
    final double centerX = radius;
    final double centerY = radius;

    // Paint for the progress with gradient colors.
    /* final Paint progressPaint = Paint()
      ..shader = SweepGradient(
        colors: backgroundGradientColors,
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        tileMode: TileMode.repeated,
      ).createShader(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; */

    // Paint for the progress track.
    final Paint progressTrackPaint = Paint()
      ..color = /* Colors.white.withOpacity(0.2) */
          const Color.fromARGB(255, 240, 240, 240)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.square;

    // Calculate the start and sweep angles to draw the progress arc.
    bool hasMoreCircles = (value > maxValue);
    double startAngle = -pi / 2;
    /* double initialSweepAngle = 2 * pi * value / maxValue; */
    List<double> SweepAngles = [2 * pi * value / maxValue];
    final int circleCount = truncateDivisor(value, maxValue);
    if (hasMoreCircles) {
      for (int i = 0; i < circleCount; i++) {
        if (i + 1 == circleCount) {
          SweepAngles.add(2 * pi * (value % maxValue) / maxValue);
        } else {
          SweepAngles.add(2 * pi);
        }
      }
      /* initialSweepAngle = 2 * pi * (value % maxValue) / maxValue; */
    }
    print('value: $value , index:  , size: $size, sweepAngles: $SweepAngles');
    // Drawing track.
    canvas.drawCircle(Offset(centerX, centerY), radius, progressTrackPaint);
    // Drawing progress.

    /* canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      initialSweepAngle,
      false,
      progressPaint,
    ); */

    /* canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      initialSweepAngle,
      false,
      lateCirclePaint,
    ); */
    for (int i = 0; i < SweepAngles.length; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        SweepAngles[i],
        false,
        lateCirclePaints[i],
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
