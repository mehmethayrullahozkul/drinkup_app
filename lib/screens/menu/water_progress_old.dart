/*

import 'dart:ui';

import 'package:drinkup_app/other/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;

/// A custom painter that creates a liquid-like animation using a sine wave.
class WaterProgressIndicator extends CustomPainter {
  double Rvalue;
  double endPoint;
  late TextPainter textPainter;
  final double upperLimit;
  final double percentFactor;
  final Color backgroundColor;
  final double scale;
  final List<Color> fillColors;
  final AnimationController stableController;
  Tween<double> _stableTween = Tween(begin: 0.0, end: 0.0);
  Animation<double>? animation;
  Animation<double>? stableAnimation;
  late final List<Paint> lateRoundPaints;
  late final List<Color> lateTextColors;

  /// Creates a [LiquidPainter] with the given [value] and [100.0].
  WaterProgressIndicator({
    required this.Rvalue,
    /* this.value = 0.0, */
    required this.upperLimit,
    this.percentFactor = 100.0,
    this.endPoint = 100.0,
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.scale = 1.0,
    required this.stableController,
    this.fillColors = const [
      Color.fromARGB(255, 0, 47, 255),
      Color.fromARGB(255, 0, 38, 255),
      Color.fromARGB(255, 55, 0, 255)
    ],
  }) : super(repaint: stableController) {
    _stableTween = Tween<double>(begin: 0.0, end: percentFactor);
    stableAnimation = _stableTween.animate(
      CurvedAnimation(
        parent: stableController,
        curve: Curves.linear,
      ),
    );

    /* if (Rvalue >= percentFactor) {
      Rvalue = percentFactor;
    } */

    lateTextColors = [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 209, 240, 255),
      Color.fromARGB(255, 72, 234, 255),
      Color.fromARGB(255, 0, 89, 255),
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 38, 0, 255),
    ];

    lateRoundPaints = [
      Paint()
        ..shader = SweepGradient(
            colors: fillColors,
            startAngle: pi / 2,
            endAngle: 5 * pi / 2,
            tileMode: TileMode.clamp,
            stops: const [
              0.15,
              0.35,
              0.55,
            ]).createShader(
            Rect.fromCircle(center: Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 0, 68, 255),
                  Color.fromARGB(255, 89, 11, 233),
                  Color.fromARGB(255, 0, 44, 240),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: const [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 9, 0, 134),
                  Color.fromARGB(255, 46, 0, 105),
                  Color.fromARGB(255, 9, 0, 136),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: const [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 83, 229, 255),
                  Color.fromARGB(255, 0, 255, 221),
                  Color.fromARGB(255, 3, 0, 46)
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: const [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: Offset(100, 100), radius: 100))
        ..style = PaintingStyle.fill,
    ];

    textPainter = TextPainter(
      text: TextSpan(
        text: '0%',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
  }

  @override
  void paint(Canvas canvas, Size size) {
    double value = Rvalue;
    /* print("value : $value - stable : ${stableAnimation!.value}"); */
    _stableTween.begin = value;
    _stableTween.end =
        min(value + 10, /* (value / 100).floor() * 100 + 100 */ endPoint);
    value = max(stableAnimation!.value, value);
    /* if (value >= 100) {
      stableController.stop();
    } */
    double heightChange = ((((1.0 - scale) / 2)) * size.height * 0.82);
    double widthChange = ((((1.0 - scale) / 2)) * size.width);
    double diameter = min(size.height * scale, size.width * scale) - 12;
    double radius = diameter / 2;

    /** */
    /*
    double pointX = widthChange + 12;
    double pointY = heightChange +
        12 +
        diameter -
        ((diameter + 10) *
            (value /
                maxValue)); // 10 is an extra offset added to fill the circle completely

    Path path = Path();
    path.moveTo(pointX, pointY);

    // Amplitude: the height of the sine wave
    double amplitude = 10;

    // Period: the time taken to complete one full cycle of the sine wave.
    // f = 1/p, the more the value of the period, the higher the frequency.
    double period = /* value / maxValue  */ 1;

    // Phase Shift: the horizontal shift of the sine wave along the x-axis.
    double phaseShift = /* value * pi */ pi * value / 4;

    double amplitudeMagnifier = 1;

    // Plotting the sine wave by connecting various paths till it reaches the diameter.
    // Using this formula: y = A * sin(ωt + φ) + C
    for (double i = 0; i <= diameter; i++) {
      if ((endPoint - value) / (endPoint * 0.16) >= 1.0) {
        amplitudeMagnifier = 1;
      } else {
        amplitudeMagnifier = ((endPoint - value) / (endPoint * 0.16));
      }
      path.lineTo(
        i + pointX,
        pointY +
            (amplitude * amplitudeMagnifier) *
                sin((i * 2 * period * pi / (diameter)) + phaseShift),
      );
    }

    // Plotting a vertical line which connects the right end of the sine wave.
    path.lineTo(pointX + diameter, diameter + heightChange + 12);
    // Plotting a vertical line which connects the left end of the sine wave.
    path.lineTo(pointX, diameter + heightChange + 12);
    // Closing the path.
    path.close();
    */
    /** */

    int roundCount = truncateDivisor(value, percentFactor);
    List<Path> paths = [];

    for (int i = 0; i <= roundCount; i++) {
      double pointX = widthChange + 12;
      double pointY = heightChange +
          12 +
          diameter -
          ((diameter + 10) *
              ((value / percentFactor) -
                  i /** no - i here normally */)); // 10 is an extra offset added to fill the circle completely

      Path path = Path();
      path.moveTo(pointX, pointY);

      // Amplitude: the height of the sine wave
      double amplitude = 10;

      // Period: the time taken to complete one full cycle of the sine wave.
      // f = 1/p, the more the value of the period, the higher the frequency.
      double period = /* value / percentFactor  */ 1;

      // Phase Shift: the horizontal shift of the sine wave along the x-axis.
      double phaseShift = /* value * pi */ pi * (value % 100) / 4;

      double amplitudeMagnifier = 1;

      // Plotting the sine wave by connecting various paths till it reaches the diameter.
      // Using this formula: y = A * sin(ωt + φ) + C
      for (double i = 0; i <= diameter; i++) {
        if ((endPoint - value) / ((100) * 0.16) >= 1.0) {
          amplitudeMagnifier = 1;
        } else {
          amplitudeMagnifier = ((endPoint - value) / ((100) * 0.16));
        }

        path.lineTo(
          i + pointX,
          pointY +
              (amplitude * amplitudeMagnifier) *
                  sin((i * 2 * period * pi / (diameter)) + phaseShift),
        );
      }

      // Plotting a vertical line which connects the right end of the sine wave.
      path.lineTo(pointX + diameter, diameter + heightChange + 12);
      // Plotting a vertical line which connects the left end of the sine wave.
      path.lineTo(pointX, diameter + heightChange + 12);
      // Closing the path.
      path.close();
      paths.add(path);
    }

    // Defining coordinate points. The wave starts from the bottom and ends at the top as the value changes.

    textPainter.text = TextSpan(
      text: '%' + Rvalue.toStringAsFixed(1),
      style: TextStyle(
        fontFamily: 'Nexa',
        letterSpacing: 1,
        fontWeight: FontWeight.w600,
        color: lateTextColors[(value / percentFactor).floor()],
        fontSize: 20.0,
      ),
    );
    textPainter.layout();

    Offset textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    Size scaledSize = Size(size.width * scale, size.height * scale);
    Path droplet = Path();
    droplet.moveTo(
        size.width * 0.5, scaledSize.height + heightChange); // first half
    droplet.relativeCubicTo(
        scaledSize.width * (0.704 - 0.5),
        /* scaledSize.height, */ 0,
        scaledSize.width * (0.852 - 0.5 - 0.012),
        scaledSize.height * 0.84 - scaledSize.height,
        scaledSize.width * (0.852 - 0.02 - 0.5 - 0.012),
        scaledSize.height * 0.65 - scaledSize.height);
    droplet.relativeCubicTo(
        /* scaledSize.width * (0.852 - 0.02) */ 0,
        scaledSize.height * 0.46 - scaledSize.height * 0.65,
        scaledSize.width * (0.521 - 0.850 + 0.012),
        scaledSize.height * 0.03 - scaledSize.height * 0.65,
        scaledSize.width * (0.500 - 0.833 + 0.012),
        scaledSize.height * 0.01 - scaledSize.height * 0.65);

    /* droplet.relativeCubicTo(
        /* scaledSize.width * 0.507 */ 0,
        /* scaledSize.height * 0.01 */ 0,
        scaledSize.width * (0.5 - 0.507),
        /* 0 */ -scaledSize.height * 0.01,
        /*  scaledSize.width * 0.493 */ -scaledSize.width * 0.007,
        /* 0.01 */ /* scaledSize.height * 0.01 */ 0); */

    droplet.moveTo(size.width * 0.5, scaledSize.height + heightChange);

    droplet.relativeCubicTo(
        scaledSize.width * (0.296 - 0.5),
        /* size.height */ 0,
        scaledSize.width * (0.148 - 0.5 + 0.012),
        scaledSize.height * 0.84 - scaledSize.height,
        scaledSize.width * (0.148 + 0.02 - 0.5 + 0.012),
        scaledSize.height * 0.65 - scaledSize.height);

    droplet.relativeCubicTo(
        /* size.width * (0.148 + 0.02) */ 0,
        scaledSize.height * 0.46 - scaledSize.height * 0.65,
        scaledSize.width * (0.479 - 0.150 - 0.012),
        scaledSize.height * 0.03 - scaledSize.height * 0.65,
        scaledSize.width * (0.481 - 0.150 - 0.012),
        scaledSize.height * 0.01 - scaledSize.height * 0.65);

    /* droplet.relativeCubicTo(
        /* size.width * 0.493 */ 0,
        /* size.height * 0.01 */ 0,
        scaledSize.width * (0.5 - 0.493),
        /*  0 */ -scaledSize.height * 0.01,
        /* size.width * 0.507 */ scaledSize.width * 0.007,
        /* 0.01 */ /* scaledSize.height * 0.01 */ 0); */

    droplet.moveTo(size.width * 0.5, scaledSize.height); // first half
    Paint dropletbg = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    /* canvas.drawPath(droplet, dropletbg); */
    //// Set the radius for the circular arcs
    /* canvas.clipPath(droplet); */

    //canvas.drawPath(droplet, paint);

    for (int i = 0; i < paths.length; i++) {
      canvas.drawPath(paths[i], lateRoundPaints[i]);
    }

    textPainter.paint(canvas, textOffset);

    /* canvas.drawPath(path, paint); */
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


*/