import 'package:drinkup_app/constants/route_constants.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart' hide Theme;
import 'constants.dart';
import 'dart:math';
import 'dart:developer' as developer;

/*******************************************/
/******* Menu Screen Constants Begin *******/
/*******************************************/

const Map<AppTheme, List<Color>> kMenuBackgroundColors = {
  AppTheme.light: [
    Color.fromARGB(255, 244, 249, 255),
    Color.fromARGB(255, 216, 234, 255),
  ],
  AppTheme.dark: [
    Color.fromARGB(255, 49, 49, 49),
    Color.fromARGB(255, 29, 29, 29),
  ]
};

/* Water Data Begin */

const double kMenuWaterDataHeightFactor = 2.0;
const double kMenuWaterDataWidthFactor = 0.8;
const double kMenuWaterDataSpacingFactor = 0.1;
const Color kMenuNotificiationIconColor = Color.fromARGB(255, 41, 41, 41);
const double kMenuNotificationIconSizeFactor = 1.0;
const List<BoxShadow> kMenuNotificationIconBoxShadow = [
  BoxShadow(
      color: Color.fromARGB(255, 228, 228, 228),
      offset: Offset(3, 3),
      blurRadius: 10,
      spreadRadius: 10),
];

const double kMenuWaterDataTopMarginFactor = 1.3;
const Map<Language, List<String>> kMenuWaterDataTitles = {
  Language.english: [
    'Target',
    'Current',
    'To Go',
  ],
  Language.turkish: [
    'Hedef',
    'Mevcut',
    'Kalan',
  ]
};

const Map<AppTheme, List<Color>> kMenuLateTextColors = {
  AppTheme.light: [
    Color.fromARGB(255, 20, 20, 20),
    Color.fromARGB(255, 250, 250, 250),
    Color.fromARGB(255, 250, 250, 250),
    Color.fromARGB(255, 250, 250, 250),
    Color.fromARGB(255, 250, 250, 250),
    Color.fromARGB(255, 250, 250, 250),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 38, 0, 255),
    Color.fromARGB(255, 98, 0, 255),
  ],
  AppTheme.dark: [
    Color.fromARGB(255, 255, 255, 255),
    Colors.white,
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 255, 255),
  ]
};

const List<double> kMenuTextColorThresholds = [70, 100, 200, 300, 400, 500];
const String kMenuWaterDataValueFontFamily = 'Aquilone';
const double kMenuWaterDataValueFontSizeFactor = 2.0;
const FontWeight kMenuWaterDataValueFontWeight = FontWeight.w600;
const double kMenuWaterDataTitleFontSizeFactor = 1.66;
const String kMenuWaterDataTitleFontFamily = 'Aquilone';
const FontWeight kMenuWaterDataTitleFontWeight = FontWeight.w300;
const List<int> kMenuWaterDataItemFlexes = [1, 2, 1];

/* Water Data End */

/* Water Animation Begin */

const Duration kMenuProgressAnimationDuration = Duration(seconds: 4);
const Duration kMenuStableAnimationDuration = Duration(seconds: 8);
const int kMenuProgressMaxDurationInMilliseconds = 6000;
const double kMenuProgressAnimationBottomPaddingFactor = 3.0;
const double kMenuDropletAnimationHeightFactor = 0.5;
const double kMenuDropletAnimationWidthFactor = 1;
const double kMenuDropletAnimationBottomPaddingFactor = 0.22;
const double kMenuDropletAnimationScaleFactor = 1;
const Map<AppTheme, Color> kMenuDropletAnimationBackgroundColor = {
  AppTheme.light: Color.fromARGB(0, 236, 249, 255),
  AppTheme.dark: Color.fromARGB(100, 53, 53, 53),
};

const double kMenuProgressPainterTextTopMarginFactor = 0.4;
/* Water Animation End */

/* Add Water Button Begin */

const EdgeInsets kMenuAddWaterButtonMargin = EdgeInsets.fromLTRB(0, 0, 0, 100);
const double kMenuAddWaterButtonRadiusFactor = 0.8;
const Map<AppTheme, Color> kMenuAddWaterButtonBackgroundColor = {
  AppTheme.light: Color.fromARGB(255, 247, 247, 247),
  AppTheme.dark: Color.fromARGB(255, 58, 61, 230),
};

const List<BoxShadow> kMenuAddWaterButtonBoxShadow = [
  BoxShadow(
      color: Color.fromARGB(23, 77, 77, 77),
      offset: Offset(0, 0),
      blurRadius: 1,
      spreadRadius: 5)
];
const double kMenuAddWaterButtonHeightFactor = 1.28;
const double kMenuAddWaterButtonWidthFactor = 9.0;
/* const double kMenuAddWaterButtonHeightFactor = 1.08;
const double kMenuAddWaterButtonWidthFactor = 9.0; */
const double kMenuAddWaterButtonLabelHeightFactor = 0.8;
const Map<Language, String> kMenuAddWaterButtonLabel = {
  Language.english: 'DRINK UP',
  Language.turkish: 'SU EKLE',
};
const double kMenuAddWaterButtonLabelFontSizeFactor = 1.81;
const String kMenuAddWaterButtonLabelFontFamily = 'Gotham';
const FontWeight kMenuAddWaterButtonLabelFontWeight = FontWeight.w800;

const Map<AppTheme, Color> kMenuAddWaterButtonLabelColor = {
  AppTheme.light: Color.fromARGB(255, 20, 20, 20),
  AppTheme.dark: Color.fromARGB(255, 255, 255, 255)
};
/* Add Water Button End */
const BorderRadius drinkListItemBorderRadius = BorderRadius.all(Radius.zero);

const BoxDecoration backgroundColor = BoxDecoration(
  color: Color.fromARGB(255, 114, 0, 63),
);

const double drinkListHeight = 60.0;
const double drinkListWidth = double.infinity;
const EdgeInsetsGeometry drinkListMargin = EdgeInsets.zero;
const EdgeInsetsGeometry drinkListPadding = EdgeInsets.zero;
const Color drinkListBackgroundColor = Colors.transparent;
const MainAxisAlignment drinkListMainAxisAligment = MainAxisAlignment.start;
const CrossAxisAlignment drinkListCrossAxisAlignment = CrossAxisAlignment.start;
const BorderRadius drinkListBorderRadius = BorderRadius.zero;
const double drinkListItemHeight = 56.0;
const double drinkListItemWidth = 70.0;
const EdgeInsetsGeometry drinkListItemMargin = EdgeInsets.zero;
const EdgeInsetsGeometry drinkListItemPadding = EdgeInsets.zero;
const Color drinkListItemBackgroundColor = Colors.transparent;

const MainAxisAlignment drinkListItemMainAxisAligment =
    MainAxisAlignment.spaceBetween;

const CrossAxisAlignment drinkListItemCrossAxisAlignment =
    CrossAxisAlignment.center;
const double drinkListItemTitleFontSize = 12.0;
const String drinkListItemTitleFontFamily = 'Sofia-Pro';
const FontWeight drinkListItemTitleFontWeight = FontWeight.w300;
const Color drinkListItemTitleColor = Color.fromARGB(255, 255, 255, 255);
const double drinkListItemLabelFontSize = 10.0;
const String drinkListItemLabelFontFamily = 'Sofia-Pro';
const FontWeight drinkListItemLabelFontWeight = FontWeight.w300;
const Color drinkListItemLabelColor = Color.fromARGB(255, 255, 255, 255);
const double drinkListItemImageHeight = 36.0;
const double drinkListItemImageWidth = 36.0;
const String drinkListItemImagePath =
    'assets/images/water-bottles/bottle-regular-1-resized.png';

const double drinkListMarginBetweenItems = 20.0;

const double drinkListItemSpaceBetweenElements = 5.0;

const List<BoxShadow> drinkListItemBoxShadow = [];

Map<AppTheme, Map<ColorTheme, List<Paint>>> kMenuLateRoundPaints = {
  AppTheme.light: {
    ColorTheme.defaultbackground: [
      Paint()
        ..shader = const SweepGradient(
                colors: [
                  Color.fromARGB(255, 0, 81, 255),
                  Color.fromARGB(255, 0, 110, 255),
                  Color.fromARGB(255, 3, 41, 255),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = const SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 45, 0, 209),
                  Color.fromARGB(255, 55, 0, 255),
                  Color.fromARGB(255, 36, 0, 240),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = const SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 4, 0, 61),
                  Color.fromARGB(255, 47, 0, 255),
                  Color.fromARGB(255, 15, 0, 221),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = const SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 48, 0, 136),
                  Color.fromARGB(255, 39, 0, 179),
                  Color.fromARGB(255, 12, 0, 185)
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = const SweepGradient(
                colors: <Color>[
                  Color.fromARGB(59, 255, 255, 255),
                  Color.fromARGB(255, 111, 0, 255),
                  Color.fromARGB(255, 47, 0, 255)
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = const SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 37, 0, 139),
                  Color.fromARGB(255, 6, 0, 59),
                  Color.fromARGB(255, 0, 9, 39)
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
    ],
    ColorTheme.defaultforeground: [
      Paint()
        ..shader = SweepGradient(
                colors: [
                  Color.fromARGB(255, 11, 1, 49),
                  Color.fromARGB(255, 25, 0, 255),
                  Color.fromARGB(255, 0, 204, 255),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 300))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 36, 0, 15),
                  Color.fromARGB(255, 88, 0, 139),
                  Color.fromARGB(255, 255, 0, 140),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 68, 0, 255),
                  Color.fromARGB(108, 0, 1, 39),
                  Color.fromARGB(255, 255, 0, 200),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 11, 1, 49),
                  Color.fromARGB(255, 25, 0, 255),
                  Color.fromARGB(255, 0, 204, 255),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 36, 36, 36),
                  Color.fromARGB(255, 129, 129, 129),
                  Color.fromARGB(255, 0, 0, 0)
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
    ],
  },

  // DARK
  AppTheme.dark: {
    ColorTheme.defaultbackground: [
      Paint()
        ..shader = SweepGradient(
                colors: [
                  /* Color.fromARGB(255, 248, 211, 0),
                  Color.fromARGB(255, 255, 166, 0),
                  Color.fromARGB(255, 214, 121, 0), */
                  Color.fromARGB(255, 61, 1, 129),
                  Color.fromARGB(255, 141, 5, 175),
                  Color.fromARGB(255, 9, 2, 26),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 21, 0, 63),
                  Color.fromARGB(255, 30, 0, 87),
                  Color.fromARGB(255, 119, 0, 255),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 16, 2, 44),
                  Color.fromARGB(255, 54, 13, 129),
                  Color.fromARGB(255, 195, 0, 255),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 104, 4, 129),
                  Color.fromARGB(255, 89, 0, 255),
                  Color.fromARGB(255, 19, 0, 41),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 132, 0, 255),
                  Color.fromARGB(255, 111, 0, 255),
                  Color.fromARGB(255, 47, 0, 255)
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
    ],
    ColorTheme.defaultforeground: [
      Paint()
        ..shader = SweepGradient(
                colors: [
                  Color.fromARGB(255, 66, 66, 66),
                  Color.fromARGB(255, 66, 66, 66),
                  Color.fromARGB(255, 66, 66, 66),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 41, 41, 41),
                  Color.fromARGB(255, 43, 43, 43),
                  Color.fromARGB(255, 32, 32, 32),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 200))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 41, 2, 49),
                  Color.fromARGB(109, 12, 12, 12),
                  Color.fromARGB(255, 0, 0, 0),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 68, 68, 68),
                  Color.fromARGB(255, 16, 16, 16),
                  Color.fromARGB(255, 63, 63, 63),
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
      Paint()
        ..shader = SweepGradient(
                colors: <Color>[
                  Color.fromARGB(255, 36, 36, 36),
                  Color.fromARGB(255, 129, 129, 129),
                  Color.fromARGB(255, 0, 0, 0)
                ],
                startAngle: pi / 2,
                endAngle: 5 * pi / 2,
                tileMode: TileMode.clamp,
                stops: [
                  0.15,
                  0.35,
                  0.55,
                ])
            .createShader(
                Rect.fromCircle(center: const Offset(400, 400), radius: 400))
        ..style = PaintingStyle.fill,
    ],
  }
};



/*******************************************/
/******* Menu Screen Constants End *********/
/*******************************************/
