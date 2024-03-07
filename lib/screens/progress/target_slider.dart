import 'package:drinkup_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LabeledSlider extends StatefulWidget {
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double>? onChanged;
  final double height;
  final double? value;

  LabeledSlider({
    required this.min,
    required this.max,
    this.height = 20,
    this.divisions = 0,
    this.onChanged,
    this.value,
  });

  @override
  _LabeledSliderState createState() => _LabeledSliderState();
}

class _LabeledSliderState extends State<LabeledSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? widget.min;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /* color: Colors.red, */
      height: widget.height,
      width: double.infinity,
      child: SliderTheme(
        data: SliderThemeData(
          /* thumbShape: SliderComponentShape.noThumb, */
          thumbShape: PolygonSliderThumb(
              sliderValue: _value, thumbRadius: widget.height),
          overlayShape:
              RoundSliderOverlayShape(overlayRadius: widget.height / 2),
          trackShape: RoundedRectSliderTrackShape(),
          trackHeight: widget.height,
          thumbColor: Color.fromARGB(255, 255, 255, 255),
          activeTrackColor: Color.fromARGB(248, 255, 255, 255),
          inactiveTrackColor: Color.fromARGB(64, 255, 255, 255),
          activeTickMarkColor: Color.fromARGB(255, 47, 0, 255),
          inactiveTickMarkColor: Color.fromARGB(0, 47, 0, 255),
          showValueIndicator: ShowValueIndicator.never,
          tickMarkShape: TickMark(),
          overlayColor: Colors.blue.withAlpha(32),
          valueIndicatorColor: Colors.blue,
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        child: Slider(
          min: widget.min,
          max: widget.max,
          divisions: (widget.divisions > 0) ? widget.divisions : null,
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
            });
            /* if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            } */
          },
          value: _value,
          label: _value.toStringAsFixed(0),
        ),
      ),
    );
  }
}

class WaterSlider extends StatelessWidget {
  final double min;
  final double max;
  final int divisions;
  late int? labelDivisions;
  final double height;

  WaterSlider(
      {required this.min,
      required this.max,
      this.labelDivisions,
      this.divisions = 1,
      this.height = 20.0}) {
    labelDivisions ??= divisions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + 32,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: height, right: height),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(labelDivisions! + 1, (index) {
                int amount = ((max - min) / labelDivisions!).toInt();
                print(amount);
                return Expanded(
                  child: Container(
                    /* color: generateRandomWhitishColor(
                        preference: 0, prominance: 0.5), */
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      /*   crossAxisAlignment: CrossAxisAlignment.start, */
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 14,
                          alignment: (index > 1)
                              ? (index < divisions - 1)
                                  ? Alignment.center
                                  : Alignment.centerRight
                              : Alignment.centerLeft,
                          /* width: double.infinity, */
                          /*  width:
                              (MediaQuery.of(context).size.width - height - 100) /
                                  6, */
                          child: Text(
                            '${(/* (min + amount / 2) */ min + amount * (index)).toStringAsFixed(0)}',

                            /* textAlign: TextAlign.center, */
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        /* SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: height,
                          width: 1,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ) */
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: LabeledSlider(
              min: min,
              max: max,
              height: height,
              divisions: divisions,
              onChanged: (value) {
                // Handle slider value change
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PolygonSliderThumb extends SliderComponentShape {
  final double thumbRadius;
  final double sliderValue;

  const PolygonSliderThumb({
    required this.thumbRadius,
    required this.sliderValue,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    int sides = 4;
    double innerPolygonRadius = thumbRadius * 1.2;
    double outerPolygonRadius = thumbRadius * 1.4;
    double angle = (pi * 2) / sides;

    /* final outerPathColor = Paint()
      ..color = Colors.pink.shade800
      ..style = PaintingStyle.fill;

    var outerPath = Path();

    Offset startPoint2 = Offset(
      outerPolygonRadius * cos(0.0),
      outerPolygonRadius * sin(0.0),
    );

    outerPath.moveTo(
      startPoint2.dx + center.dx,
      startPoint2.dy + center.dy,
    );

    for (int i = 1; i <= sides; i++) {
      double x = outerPolygonRadius * cos(angle * i) + center.dx;
      double y = outerPolygonRadius * sin(angle * i) + center.dy;
      outerPath.lineTo(x, y);
    }

    outerPath.close();
    canvas.drawPath(outerPath, outerPathColor); */

    final innerPathColor = Paint()
      ..color = Color.fromARGB(255, 0, 110, 255)
      ..style = PaintingStyle.fill;

    var innerPath = Path();

    /* innerPath
        .addOval(Rect.fromCircle(center: center, radius: thumbRadius * 1.8)); */
    innerPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromCircle(center: center, radius: thumbRadius * 1.5),
        Radius.circular(100)));

    innerPath.close();

    var clipPath = Path();
    clipPath.addRect(Rect.fromCenter(
        center: center, width: thumbRadius * 3, height: thumbRadius * 1.6));

    clipPath.close();
    canvas.clipPath(clipPath);
    canvas.drawPath(innerPath, innerPathColor);

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: 11,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      text: sliderValue.round().toString(),
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    Offset textCenter = Offset(
      center.dx - (tp.width / 2),
      center.dy - (tp.height / 2),
    );

    tp.paint(canvas, textCenter);
  }

  // ...
}

class TickMark extends SliderTickMarkShape {
  final double height;

  TickMark({this.height = 10});

  @override
  Size getPreferredSize(
      {required SliderThemeData sliderTheme, required bool isEnabled}) {
    return Size.fromRadius(10);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required Offset thumbCenter,
      required bool
          isEnabled /* , required bool isDiscrete, required bool isOnTop */}) {
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..color = Color.fromARGB(139, 255, 255, 255)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      Offset(center.dx, center.dy - height / 2),
      Offset(center.dx, center.dy + height / 2),
      paint,
    );
  }
}
