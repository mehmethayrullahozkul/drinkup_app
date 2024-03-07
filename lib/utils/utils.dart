import 'dart:math' as math;
import 'package:drinkup_app/constants/constants.dart';
import 'package:drinkup_app/constants/menu_constants.dart';
import 'package:flutter/material.dart';

Color getMenuTextColorByProgress(double progress, AppTheme theme) {
  /* int index = (progress / 100).floor();

  widget.color = (index < 1)
      ? (state.progress > 70)
          ? Colors.white
          : const Color.fromARGB(255, 50, 50, 50)
      : MenuScreenConstants.lateTextColors[index]; */
  int i = 0;
  while (progress > kMenuTextColorThresholds[i] && i < 10) {
    i++;
  }

  return kMenuLateTextColors[theme]![i];
}

const List<Color> blueBackgroundColors = [
  Color.fromARGB(255, 0, 81, 255),
  Color.fromARGB(255, 4, 77, 211),
  Color.fromARGB(255, 3, 91, 255),
  Color.fromARGB(255, 0, 68, 255),
  Color.fromARGB(255, 89, 11, 233),
  Color.fromARGB(255, 0, 44, 240),
  Color.fromARGB(255, 9, 0, 134),
  Color.fromARGB(255, 46, 0, 105),
  Color.fromARGB(255, 9, 0, 136),
  Color.fromARGB(255, 0, 11, 161),
  Color.fromARGB(255, 25, 0, 255),
  Color.fromARGB(255, 12, 0, 185),
  Color.fromARGB(255, 46, 22, 255),
  Color.fromARGB(255, 0, 60, 255),
  Color.fromARGB(255, 37, 0, 139),
  Color.fromARGB(255, 6, 0, 59),
  Color.fromARGB(255, 0, 9, 39)
];

const List<Color> progressKarmaColors = [
  Color.fromARGB(255, 0, 255, 179),
  Color.fromARGB(255, 0, 47, 255),
  Color.fromARGB(255, 0, 255, 183),
  Color.fromARGB(255, 0, 255, 179),
  Color.fromARGB(255, 0, 140, 255),
  Color.fromARGB(255, 0, 255, 183),
  Color.fromARGB(255, 0, 255, 26),
  Color.fromARGB(255, 255, 74, 3),
  Color.fromARGB(255, 255, 8, 0),
  Color.fromARGB(255, 247, 0, 255),
  Color.fromARGB(255, 104, 0, 202),
  Color.fromARGB(255, 0, 26, 255),
  Color.fromARGB(255, 6, 0, 95),
  Color.fromARGB(255, 46, 22, 255),
  Color.fromARGB(255, 0, 60, 255),
  Color.fromARGB(255, 37, 0, 139),
  Color.fromARGB(255, 6, 0, 59),
  Color.fromARGB(255, 0, 9, 39)
];

int truncateDivisor(double numb, double divisor) {
  if (divisor <= 0.0 || numb <= 0.0) {
    return 0;
  }
  int count = 0;
  double copy = numb;
  while (copy > divisor) {
    copy -= divisor;
    count++;
  }
  return count;
}

Color generateRandomWhitishColor(
    {double opacity = 1,
    int start = 200,
    int preference = 0,
    double prominance = 1}) {
  final int random = math.Random().nextInt(3);
  final int next = 256 - start;
  const Color.fromARGB(255, 226, 157, 6);
  switch (preference) {
    case 0:
      {
        switch (random) {
          case 0:
            {
              final int red = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int green = math.Random()
                  .nextInt(next); // Random value between 200 and 255
              final int blue = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 1:
            {
              final int red = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int green = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = math.Random()
                  .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 2:
            {
              final int red = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int green = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
        }
      }
    case 1:
      {
        switch (random) {
          case 0:
            {
              final int red = math.Random()
                  .nextInt(next); // Random value between 200 and 255
              final int green = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 1:
            {
              final int red = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int green = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = math.Random()
                  .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 2:
            {
              final int red = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int green = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
        }
      }
    case 2:
      {
        switch (random) {
          case 0:
            {
              final int red = math.Random()
                  .nextInt(next); // Random value between 200 and 255
              final int green = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 1:
            {
              final int red = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int green = math.Random()
                  .nextInt(next); // Random value between 200 and 255
              final int blue = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
          case 2:
            {
              final int red = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int green = ((1 - prominance) * start).toInt() +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              final int blue = start +
                  math.Random()
                      .nextInt(next); // Random value between 200 and 255
              return Color.fromRGBO(red, green, blue, opacity);
            }
        }
      }
  }
  return Color.fromRGBO(255, 255, 255, opacity);
}

Paint generatePaintWithGivenSize(
    {required double strokeWidth,
    required double size,
    double prominance = 1,
    double opacity = 1,
    required int preference,
    int start = 200}) {
  final Paint paint = Paint()
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.values[math.Random().nextInt(100)]
    ..shader = SweepGradient(
            colors: [
              generateRandomWhitishColor(
                  start: start, preference: preference, prominance: prominance),
              generateRandomWhitishColor(
                  start: start, preference: preference, prominance: 0.5),
              generateRandomWhitishColor(
                  start: start, preference: preference, prominance: prominance),
            ],
            startAngle: math.pi / 2,
            endAngle: 5 * math.pi / 2,
            tileMode: TileMode.clamp,
            stops: [
              0.15,
              0.35,
              0.55,
            ])
        .createShader(
            Rect.fromCircle(center: Offset(size, size), radius: size));
  return paint;
}

Paint getPaintWithGivenSize(
    {required double strokeWidth, required double size, required int index}) {
  final Paint paint = Paint()
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round
    ..shader = SweepGradient(
            colors: [
              progressKarmaColors[index * 2],
              progressKarmaColors[index * 2 + 1],
              progressKarmaColors[index * 2],
            ],
            startAngle: math.pi / 2,
            endAngle: 5 * math.pi / 2,
            tileMode: TileMode.clamp,
            stops: [
              0.15,
              0.35,
              0.55,
            ])
        .createShader(
            Rect.fromCircle(center: Offset(size, size), radius: size));
  return paint;
}
