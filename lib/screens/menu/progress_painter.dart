import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/utils/utils.dart' as Utils;
import 'dart:math';

class ProgressPainter extends CustomPainter {
  final Constants.AppTheme theme;
  final double value;
  final double percentFactor;
  late TextPainter textPainterPercentage;
  late TextPainter textPainterAmount;
  final Animation<double> animationController;
  late final double? dataTopMargin;
  final int amount;
  final int target;

  // Constructor to initialize the RadialProgressPainter with required parameters.
  ProgressPainter({
    this.theme = Constants.AppTheme.light,
    required this.target,
    required this.amount,
    this.dataTopMargin,
    required this.value,
    this.percentFactor = 100,
    required this.animationController,
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
  }

  @override
  void paint(Canvas canvas, Size size) {
    int index = (value / percentFactor).floor();

    // Radius

    /* textPainterAmount.text = TextSpan(
      text: '$amount ml',
      style: TextStyle(
        fontFamily: 'Nexa',
        letterSpacing: 1,
        fontWeight: FontWeight.w300,
        color: Constants.kMenuLateTextColors[theme]![index],
        fontSize: 20.0,
      ),
    );
    textPainterAmount.layout(); */

    textPainterPercentage.text = TextSpan(
      /* text: /* '%' +
          value.toStringAsFixed(
              1) */
          '${(value * target * 0.01).toStringAsFixed(0)} ', */
      children: [
        TextSpan(
          text: '${(value * target * 0.01).toStringAsFixed(0)}',
          style: TextStyle(
            fontFamily: 'Zuume-Soft',
            fontSize: SizeService().fontSize * 9,
            color: Utils.getMenuTextColorByProgress(value, theme),
          ),
        ),
        TextSpan(
          text: ' ml',
          style: TextStyle(
            fontFamily: 'Brandon-Grotesque',
            fontSize: SizeService().fontSize * 2,
            color: Utils.getMenuTextColorByProgress(value, theme),
          ),
        ),
      ],
      style: TextStyle(
        fontFamily: 'Zuume-Soft',
        letterSpacing: 1,
        /* fontWeight: FontWeight.w500, */
        color: /* (index < 1)
            ? (value > 40)
                ? Colors.white
                : const Color.fromARGB(255, 50, 50, 50)
            : Constants.kMenuLateTextColors[theme]![index], */
            Utils.getMenuTextColorByProgress(value, theme),
        fontSize: SizeService().fontSize * 6,
      ),
    );
    textPainterPercentage.layout();

    Offset percentageTextOffset = Offset(
      (size.width - textPainterPercentage.width) / 2,
      dataTopMargin == null
          ? (size.height - textPainterPercentage.height) / 2
          : size.height - textPainterPercentage.height - dataTopMargin!,
    );

    textPainterPercentage.paint(canvas, percentageTextOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
