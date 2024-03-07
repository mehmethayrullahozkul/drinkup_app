import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:drinkup_app/constants/constants.dart';

// create all constants for Progress.dart in screens folder

const Map<AppTheme, List<Color>> kProgressBackgroundColors = {
  AppTheme.light: [
    /* Color.fromARGB(255, 0, 102, 255),
    Color.fromARGB(255, 0, 60, 255) */
    /* Color.fromARGB(255, 31, 5, 180),
    Color.fromARGB(255, 50, 1, 56),
    Color.fromARGB(255, 4, 50, 150), */
    Color.fromARGB(255, 13, 71, 179),
    Color.fromARGB(255, 13, 71, 179),
  ],
  AppTheme.dark: [
    Color.fromARGB(255, 20, 20, 20),
    Color.fromARGB(255, 19, 19, 19)
  ],
};

const double kProgressSectionOuterPaddingVerticalFactor = 0.1;
const double kProgressSectionOuterPaddingHorizontalFactor = 0.4;
const double kProgressSectionOuterTopMarginFactor = 0.2;
const double kProgressSectionOuterMarginHorizontalFactor = 0.4;
const double kProgressSectionInnerPaddingFactor = 1;
const Color kProgressSectionBackgroundColor = Color.fromARGB(24, 255, 255, 255);
const Color kProgressSingleBoxBackgroundColor =
    Color.fromARGB(24, 255, 255, 255);
const double kProgressSectionBorderRadiusFactor = 0.4;
const Color kProgressSectionBorderColor = Color.fromARGB(32, 199, 199, 199);
const Color kProgressSingleBoxBorderColor = Color.fromARGB(32, 199, 199, 199);
const double kProgressSectionBorderWidthFactor = 0.02;
const double kProgressSectionInnerListPaddingFactor = 0.40;

const Map<Language, String> kProgressProgressSectionTitle = {
  Language.english: 'Progress',
  Language.turkish: 'İstatistikler',
};

const Map<Language, List<String>> kProgressProgressSectionSubtitle = {
  Language.english: [
    'Daily Goal',
    'Currently At',
    'Before Target',
  ],
  Language.turkish: [
    'Günlük Hedef',
    'Bugün İçilen',
    'Hedefe Kadar',
  ],
};

const String kProgressProgressSectionSubtitleFontFamily = 'Sofia-Pro';
const double kProgressProgressSectionSubtitleFontSizeFactor = 1;
const FontWeight kProgressProgressSectionSubtitleFontWeight = FontWeight.w500;
const Map<AppTheme, Color> kProgressProgressSectionSubtitleColor = {
  AppTheme.light: Color.fromARGB(160, 255, 255, 255),
  AppTheme.dark: Color.fromARGB(188, 255, 255, 255),
};

const String kProgressProgressSectionTitleFontFamily = 'Sofia-Pro';
const double kProgressProgressSectionTitleFontSizeFactor = 1.8;
const FontWeight kProgressProgressSectionTitleFontWeight = FontWeight.w600;
const Color kProgressProgressSectionTitleColor = Colors.white;

const double kProgressProgressSectionCircleOuterSizeFactor = 6;
const double kProgressProgressSectionCircleInnerSizeFactor = 4;
const double kProgressProgressSectionCircleStrokeWidthFactor = 0.4;

const double kProgressProgressSectionSubtitleSpacingFactor = 0.2;

const String kProgressProgressSectionValueFontFamily = 'Gotham';
const double kProgressProgressSectionValueFontSizeFactor = 1.16;
const FontWeight kProgressProgressSectionValueFontWeight = FontWeight.w600;
const Map<AppTheme, Color> kProgressProgressSectionValueColor = {
  AppTheme.light: Color.fromARGB(255, 255, 255, 255),
  AppTheme.dark: Color.fromARGB(255, 255, 255, 255),
};

const double kProgressSectionBetweenSpacingFactor = 0.2;

const double kProgressSingleBoxBorderRadiusFactor = 0.4;

const double kProgressSingleBoxHeightFactor = 2;

const double kProgressSingleBoxPaddingFactor = 0.7;

const Map<Language, List<String>> kProgressSingleBoxTitle = {
  Language.english: [
    'Daily Average',
    'Weekly Total',
    'Day Streak',
  ],
  Language.turkish: [
    'Günlük Ortalama',
    'Haftalık Toplam',
    'Gün Serisi',
  ]
};

const Color kProgressSingleBoxTitleColor = Color.fromARGB(255, 223, 223, 223);
const String kProgressSingleBoxTitleFontFamily = 'Sofia-Pro';
const double kProgressSingleBoxTitleFontSizeFactor = 1.16;
const FontWeight kProgressSingleBoxTitleFontWeight = FontWeight.w300;

const Color kProgressSingleBoxValueColor = Colors.white;
const String kProgressSingleBoxValueFontFamily = 'Brandon-Grotesque';
const double kProgressSingleBoxValueFontSizeFactor = 1.66;
const FontWeight kProgressSingleBoxValueFontWeight = FontWeight.w900;

const double kProgressSingleBoxHorizontalMarginFactor = 0.4;

const Map<Language, String> kProgressAppBarTitle = {
  Language.english: 'Progress',
  Language.turkish: 'İlerleme',
};


    /* EdgeInsets.symmetric(vertical: 5, horizontal: 10); */
