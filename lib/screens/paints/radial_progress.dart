import 'package:flutter/material.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/constants/menu_constants.dart' as MenuConstants;
import 'package:drinkup_app/utils/utils.dart';
import 'dart:math';

class RadialProgressPainter extends CustomPainter {
  final Constants.AppTheme theme;
  final double strokeWidth;
  final double value;
  final Color percentTextColor;
  final double percentFontSize;
  final FontWeight percentFontWeight;
  final String percentFontFamily;
  final double percentFactor;
  final double scale;
  late TextPainter textPainterPercentage;
  late TextPainter textPainterAmount;

  late final double? dataTopMargin;
  final int target;
  late final List<Paint> lateCirclePaints;

  // Constructor to initialize the RadialProgressPainter with required parameters.
  RadialProgressPainter({
    required this.target,
    this.theme = Constants.AppTheme.light,
    this.percentTextColor = const Color.fromARGB(255, 255, 255, 255),
    this.percentFontSize = 36.0,
    this.percentFontWeight = FontWeight.w900,
    this.percentFontFamily = 'Brandon-Grotesque',
    this.dataTopMargin,
    this.strokeWidth = 10.0,
    required this.value,
    this.percentFactor = 100,
    this.scale = 1.0,
  }) {
    textPainterPercentage = TextPainter(
      text: const TextSpan(
        text: '0%',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainterPercentage.layout();

    textPainterAmount = TextPainter(
      text: const TextSpan(
        text: '0%',
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainterAmount.layout();

    lateCirclePaints = List.generate(
      5,
      (index) => Paint()
        ..color = MenuConstants.kMenuLateTextColors[theme]![index]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.square
        ..shader = SweepGradient(
          colors: MenuConstants.kMenuLateTextColors[theme]!,
          startAngle: -pi / 2,
          endAngle: 3 * pi / 2,
          tileMode: TileMode.repeated,
        ).createShader(
          Rect.fromCircle(
            center: Offset(100, 00),
            radius: 100,
          ),
        ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    /* canvas.clipRect(Offset.zero & size); */
    int index = (value / 100).floor();
    /* print('Size: $size'); */
    // circle's diameter // taking min side as diameter
    double heightChange = ((((1.0 - scale) / 2)) * size.height * 1);
    double widthChange = ((((1.0 - scale) / 2)) * size.width);
    final double diameter = min(size.height * scale, size.width * scale);
    // Radius
    final double radius = diameter / 2;
    // Center cordinate
    final double centerX = radius + widthChange;
    final double centerY = radius + heightChange;

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
    bool hasMoreCircles = (value > percentFactor);
    double startAngle = -pi / 2;
    List<double> SweepAngles = [];
    final int circleCount = truncateDivisor(value, percentFactor);

    for (int i = 0; i <= circleCount; i++) {
      SweepAngles.add(2 * pi * (((value) / percentFactor) - i));
      /* if (i == circleCount) {
        SweepAngles.add(2 * pi * (value % 100) / 100);
      } else {
        SweepAngles.add(2 * pi);
      } */
    }

    textPainterPercentage.text = TextSpan(
      text: '%' +
          value.toStringAsFixed(
              1) /* '${(value * target * 0.01).toStringAsFixed(0)} ml' */,
      style: TextStyle(
        fontFamily: percentFontFamily,
        letterSpacing: 0,
        fontWeight: percentFontWeight,
        color: percentTextColor,
        fontSize: percentFontSize,
      ),
    );
    textPainterPercentage.layout();

    Offset percentageTextOffset = Offset(
      (size.width - textPainterPercentage.width) / 2,
      dataTopMargin == null
          ? (size.height - textPainterPercentage.height) / 2
          : size.height - textPainterPercentage.height - dataTopMargin!,
    );

    Offset amountTextOffset = Offset(
      (size.width - textPainterAmount.width) / 2,
      dataTopMargin == null
          ? (size.height - textPainterAmount.height) / 6
          : (size.height - textPainterAmount.height) / 3 - dataTopMargin!,
    );
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
    /* print(
        'value: $value , index: $index , size: $size, sweepAngles: $SweepAngles'); */
    for (int i = 0; i < SweepAngles.length; i++) {
      canvas.drawArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          startAngle,
          SweepAngles[i],
          false,
          /* MenuScreenConstants.lateRoundPaints[i] */
          /* lateCirclePaints[i], */
          getPaintWithGivenSize(
              strokeWidth: strokeWidth * (1), size: size.width, index: i));
    }
    /* textPainterAmount.paint(canvas, amountTextOffset); */
    textPainterPercentage.paint(canvas, percentageTextOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
