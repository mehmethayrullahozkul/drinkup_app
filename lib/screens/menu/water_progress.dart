import 'package:drinkup_app/utils/utils.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/constants/menu_constants.dart' as MenuConstants;
import 'package:flutter/material.dart';
import 'dart:math';

/// A custom painter that creates a liquid-like animation using a sine wave.
class WaterProgressIndicator extends CustomPainter {
  final int foregroundColorIndex;
  final int backgroundColorIndex;
  final bool stableAnimationEnabled;
  final Constants.AppTheme theme;
  final Constants.ColorTheme colorTheme;
  double Rvalue;
  final bool hasInitialBackground;
  final bool isCircular;
  double endPoint;
  final double bottomElevation;
  final bool isDroplet;
  final double percentFactor;
  final Color backgroundColor;
  final double scale;
  final List<Color> fillColors;
  final AnimationController? stableController;
  Tween<double> _stableTween = Tween(begin: 0.0, end: 0.0);
  Animation<double>? animation;
  Animation<double>? stableAnimation;
  late final double? dataTopMargin;
  bool _isStableActive = false;
  double _oldValue = 0;
  double _diff = 0;

  double _pointX = 0;
  double _pointY = 0;
  Path path = Path();

  /// Creates a [LiquidPainter] with the given [value] and [100.0].
  WaterProgressIndicator({
    this.theme = Constants.AppTheme.light,
    this.colorTheme = Constants.ColorTheme.defaultbackground,
    this.hasInitialBackground = false,
    this.foregroundColorIndex = 0,
    this.backgroundColorIndex = 0,
    this.stableAnimationEnabled = true,
    this.isDroplet = false,
    this.bottomElevation = 0,
    this.dataTopMargin,
    this.isCircular = true,
    required this.Rvalue,
    this.percentFactor = 100.0,
    this.endPoint = 100.0,
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.scale = 1.0,
    this.stableController,
    this.fillColors = const [
      Color.fromARGB(255, 0, 47, 255),
      Color.fromARGB(255, 0, 38, 255),
      Color.fromARGB(255, 55, 0, 255)
    ],
  }) : super(repaint: stableController) {
    if (stableAnimationEnabled) {
      _isStableActive = (_oldValue == Rvalue);
      _stableTween = Tween<double>(begin: 0.0, end: percentFactor);
      stableAnimation = _stableTween.animate(
        CurvedAnimation(
          parent: stableController!,
          curve: Curves.linear,
        ),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    /* paths.clear(); */
    double value = Rvalue;
    if (stableAnimationEnabled) {
      _isStableActive = (_oldValue == Rvalue);
      _stableTween.begin = value;
      _stableTween.end =
          min(value + 8, /* (value / 100).floor() * 100 + 100 */ endPoint);

      value = max(stableAnimation!.value, value);
    }

    _diff = Rvalue - value;

    double heightChange = ((((1.0 - scale) / 2)) * size.height * 1);
    double widthChange = ((((1.0 - scale) / 2)) * size.width);
    double diameter = /* min(size.height * scale, size.width * scale) - 0; */
        (isCircular
            ? min(size.height * scale, size.width * scale)
            : max(size.width * scale, size.height * scale) - bottomElevation);
    double shortDiameter = min(size.height * scale, size.width * scale);

    /* double radius = diameter / 2; */

    /* print(value); */
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
    int i = roundCount;

    /* for (int i = 0; i <= roundCount; i++) { */
    _pointX = widthChange;
    _pointY = /* (_isStableActive)
        ? heightChange +
            /* -150 + */
            diameter -
            ((diameter + 10) *
                ((Rvalue / percentFactor) - i /** no - i here normally */))
        : */
        heightChange +
            /* -150 + */
            diameter -
            ((diameter + 10) *
                ((value / percentFactor) -
                    i /** no - i here normally */)); // 10 is an extra offset added to fill the circle completely

    /* Path */ path = Path();

    path.moveTo(_pointX, _pointY);

    // Amplitude: the height of the sine wave
    double amplitude = (isDroplet) ? 0 : 40;

    // Period: the time taken to complete one full cycle of the sine wave.
    // f = 1/p, the more the value of the period, the higher the frequency.
    double period = /* value / percentFactor  */ 1.4;

    // Phase Shift: the horizontal shift of the sine wave along the x-axis.
    double phaseShift = /* value * pi */ /* pi * (value % 100) / 4 */
        /* (_isStableActive) ? _diff * 1.2 : */ (_diff * 1);
    /* print(pointY); */
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
        min(i, shortDiameter) + _pointX,
        _pointY +
            (amplitude * amplitudeMagnifier) *
                sin((i * 2 * period * pi / (diameter)) + phaseShift),
      );
    }

    // Plotting a vertical line which connects the right end of the sine wave.
    path.lineTo(
        _pointX + shortDiameter, diameter + heightChange + bottomElevation);
    // Plotting a vertical line which connects the left end of the sine wave.
    path.lineTo(_pointX, diameter + heightChange + bottomElevation);
    // Closing the path.
    path.close();
    /* paths.add(path); */
    /* } */

    // Defining coordinate points. The wave starts from the bottom and ends at the top as the value changes.

    /* textPainter.text = TextSpan(
      text: '%' + Rvalue.toStringAsFixed(1),
      style: TextStyle(
        fontFamily: 'Nexa',
        letterSpacing: 1,
        fontWeight: FontWeight.w700,
        color: lateTextColors[(value / percentFactor).floor()],
        fontSize: 50.0,
      ),
    );
    textPainter.layout(); */

    /* Offset textOffset = Offset(
      (size.width - textPainter.width) / 2,
      dataTopMargin == null
          ? (size.height - textPainter.height) / 2
          : size.height - textPainter.height - dataTopMargin!,
    ); */
    if (isDroplet) {
      Size scaledSize;

      scaledSize = (isCircular)
          ? Size(diameter, diameter)
          : Size(size.height * scale, size.width * scale);
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

      droplet.moveTo(size.width * 0.5, scaledSize.height); // first half */

      //// Set the radius for the circular arcs
      /* canvas.clipPath(droplet); */

      canvas.clipPath(droplet);
    }

    /* canvas.drawPaint(dropletbg); */

    //canvas.drawPath(droplet, paint);

    /* for (int i = 0; i < paths.length; i++) { */

    /* print('Painting path $i'); */

    /* (hasBackground)
        ? canvas.drawPaint(MenuScreenConstants.lateRoundPaints[0])
        : null; */

    if (i >= 1) {
      canvas.drawPaint(MenuConstants.kMenuLateRoundPaints[theme]![colorTheme]![
          i + backgroundColorIndex - 1]);
    } else {
      if (hasInitialBackground)
        canvas.drawPaint(Paint()..color = backgroundColor);
    }

    /* if (roundCount > 0) {
      /* canvas.drawPath(droplet, dropletbg); */
      (hasBackground)
          ? canvas
              .drawPaint(MenuScreenConstants.lateRoundPaints[i + coloringIndex])
          : null;
    } */

    canvas.drawPath(
        path,
        MenuConstants.kMenuLateRoundPaints[theme]![colorTheme]![
            i + backgroundColorIndex]);
    /* } */

    /* textPainter.paint(canvas, textOffset); */

    /* canvas.drawPath(path, paint); */
    _oldValue = Rvalue;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
