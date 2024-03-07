library constants;

import 'package:drinkup_app/constants/route_constants.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart' hide Theme;
import 'dart:math';
import 'dart:developer' as developer;

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

/*
  This file contains the constants used in the application.
  The constants are used to define the styles and the dimensions of the widgets.
 */

const bool debugEnabled = true;

void developerLog(String message) {
  // Set this flag to control debug statements

  if (debugEnabled) {
    developer.log(message, name: 'DrinkUp');
  }
}

enum AppTheme {
  light,
  dark;

  @override
  String toString() {
    return this.name;
  }

  static AppTheme fromString(String theme) {
    for (AppTheme appTheme in AppTheme.values) {
      if (appTheme.name == theme) {
        return appTheme;
      }
    }
    return AppTheme.light;
  }

  String toStringInLanguage(Language language) {
    if (language == Language.english) {
      {
        if (this == AppTheme.light) {
          return "Light";
        } else if (this == AppTheme.dark) {
          return "Dark";
        }
      }
    } else if (language == Language.turkish) {
      {
        if (this == AppTheme.light) {
          return "Açık";
        } else if (this == AppTheme.dark) {
          return "Koyu";
        }
      }
    }
    return "";
  }
}

enum ColorTheme { defaultbackground, defaultforeground }

enum Language {
  turkish,
  english;

  @override
  String toString() {
    return name;
  }

  static Language fromString(String language) {
    for (Language lang in Language.values) {
      if (lang.name == language) {
        return lang;
      }
    }
    return Language.english;
  }

  String toStringInLanguage() {
    if (this == Language.english) {
      {
        return "English";
      }
    } else if (this == Language.turkish) {
      {
        return "Türkçe";
      }
    }
    return "";
  }
}

enum AppWaterUnit {
  ml,
  oz;

  @override
  String toString() {
    return name;
  }

  static AppWaterUnit fromString(String unit) {
    for (AppWaterUnit appWaterUnit in AppWaterUnit.values) {
      if (appWaterUnit.name == unit) {
        return appWaterUnit;
      }
    }
    return AppWaterUnit.ml;
  }

  String toStringInLanguage(Language language) {
    if (language == Language.english) {
      {
        if (this == AppWaterUnit.ml) {
          return "ml";
        } else if (this == AppWaterUnit.oz) {
          return "oz";
        }
      }
    } else if (language == Language.turkish) {
      {
        if (this == AppWaterUnit.ml) {
          return "ml";
        } else if (this == AppWaterUnit.oz) {
          return "oz";
        }
      }
    }
    return "";
  }
}

enum TimeFormat {
  ampm,
  twentyfour;

  @override
  String toString() {
    return name;
  }

  static TimeFormat fromString(String format) {
    for (TimeFormat timeFormat in TimeFormat.values) {
      if (timeFormat.name == format) {
        return timeFormat;
      }
    }
    return TimeFormat.twentyfour;
  }

  String toStringInLanguage(Language language) {
    if (language == Language.english) {
      {
        if (this == TimeFormat.ampm) {
          return "AM/PM";
        } else if (this == TimeFormat.twentyfour) {
          return "24-Hour";
        }
      }
    } else if (language == Language.turkish) {
      {
        if (this == TimeFormat.ampm) {
          return "AM/PM";
        } else if (this == TimeFormat.twentyfour) {
          return "24-Saat";
        }
      }
    }
    return "";
  }
}

enum ReminderType {
  notification,
  alarm,
  none;

  @override
  String toString() {
    return name;
  }

  static ReminderType fromString(String type) {
    for (ReminderType reminderType in ReminderType.values) {
      if (reminderType.name == type) {
        return reminderType;
      }
    }
    return ReminderType.notification;
  }

  String toStringInLanguage(Language language) {
    if (language == Language.english) {
      {
        if (this == ReminderType.notification) {
          return "Notification";
        } else if (this == ReminderType.alarm) {
          return "Alarm";
        } else if (this == ReminderType.none) {
          return "None";
        }
      }
    } else if (language == Language.turkish) {
      {
        if (this == ReminderType.notification) {
          return "Bildirim";
        } else if (this == ReminderType.alarm) {
          return "Alarm";
        } else if (this == ReminderType.none) {
          return "Hiçbiri";
        }
      }
    }
    return "";
  }
}

enum ReminderInterval {
  daily,
  hourly,
  everytwohours,
  everythreehours,
  everysixhours,
  everytwelvehours,
  none;

  @override
  String toString() {
    return name;
  }

  static ReminderInterval fromString(String interval) {
    for (ReminderInterval reminderInterval in ReminderInterval.values) {
      if (reminderInterval.name == interval) {
        return reminderInterval;
      }
    }
    return ReminderInterval.hourly;
  }

  String toStringInLanguage(Language language) {
    if (language == Language.english) {
      {
        if (this == ReminderInterval.daily) {
          return "Daily";
        } else if (this == ReminderInterval.hourly) {
          return "Hourly";
        } else if (this == ReminderInterval.everytwohours) {
          return "Every Two Hours";
        } else if (this == ReminderInterval.everythreehours) {
          return "Every Three Hours";
        } else if (this == ReminderInterval.everysixhours) {
          return "Every Six Hours";
        } else if (this == ReminderInterval.everytwelvehours) {
          return "Every Twelve Hours";
        } else if (this == ReminderInterval.none) {
          return "None";
        }
      }
    } else if (language == Language.turkish) {
      {
        if (this == ReminderInterval.daily) {
          return "Günlük";
        } else if (this == ReminderInterval.hourly) {
          return "Saatlik";
        } else if (this == ReminderInterval.everytwohours) {
          return "Her İki Saatte";
        } else if (this == ReminderInterval.everythreehours) {
          return "Her Üç Saatte";
        } else if (this == ReminderInterval.everysixhours) {
          return "Her Altı Saatte";
        } else if (this == ReminderInterval.everytwelvehours) {
          return "Her On İki Saatte";
        } else if (this == ReminderInterval.none) {
          return "Hiçbiri";
        }
      }
    }
    return "";
  }
}

const Map<AppTheme, Color> kMainBackgroundColor = {
  AppTheme.dark: Color.fromARGB(255, 41, 41, 41),
  AppTheme.light: Color.fromARGB(255, 12, 0, 80)
};

/* const int MAX_WATER_AMOUNT = 8000;
const int MIN_WATER_ADD_AMOUNT = 100;
const int MAX_WATER_ADD_AMOUNT = 1000; */

/*******************************************/
/****** Screen Draft Constants Begin *******/
/*******************************************/

const Map<AppTheme, Color> kBottomNavigationBarBackgroundColor = {
  AppTheme.dark: Color.fromARGB(255, 20, 20, 20),
  AppTheme.light: Color.fromARGB(255, 24, 76, 187),
};

const double kBottomNavigationBarHeightFactor = 1.2;
const double kBottomNavigationBarWidthFactor = 1.0;
const double kBottomNavigationBarIconSizeFactor = 1.0;
const FontWeight kBottomNavigationBarFontWeight = FontWeight.w400;
const double kBottomNavigationBarLabelFontSizeFactor = 0.9;
const String kBottomNavigationBarFontFamily = 'Sofia-Pro';
const double kBottomNavigationSpaceBetweenItemsFactor = 0.08;
const Color kBottomNavigationBarSelectedIconColor = Colors.white;
const Color kBottomNavigationBarUnselectedIconColor =
    Color.fromARGB(199, 255, 255, 255);
const Map<Language, List<Map<String, dynamic>>> kBottomNavigationBarRoutes = {
  Language.english: [
    {
      "iconFilled": Icons.water_drop,
      "iconOutlined": Icons.water_drop_outlined,
      "label": "Today"
    },
    {
      "iconFilled": Icons.book,
      "iconOutlined": Icons.book_outlined,
      "label": "History"
    },
    {
      "iconFilled": Icons.insert_chart,
      "iconOutlined": Icons.insert_chart_outlined,
      "label": "Progress"
    },
    {
      "iconFilled": Icons.person,
      "iconOutlined": Icons.person_outline,
      "label": "Me"
    },
    /* {
      "iconFilled": Icons.notifications,
      "iconOutlined": Icons.notifications_outlined,
      "label": "Notifications"
    }, */
  ],
  Language.turkish: [
    {
      "iconFilled": Icons.water_drop,
      "iconOutlined": Icons.water_drop_outlined,
      "label": "Bugün"
    },
    {
      "iconFilled": Icons.book,
      "iconOutlined": Icons.book_outlined,
      "label": "Geçmiş"
    },
    {
      "iconFilled": Icons.insert_chart,
      "iconOutlined": Icons.insert_chart_outlined,
      "label": "İlerleme"
    },
    {
      "iconFilled": Icons.person,
      "iconOutlined": Icons.person_outline,
      "label": "Ben"
    },
    /* {
      "iconFilled": Icons.notifications,
      "iconOutlined": Icons.notifications_outlined,
      "label": "Bildirimler"
    }, */
  ]
};

/*******************************************/
/******* Screen Draft Constants End ********/
/*******************************************/

/*******************************************/
/******** Profile Constants Begin **********/
/*******************************************/

/*******************************************/
/******** Profile Constants End ************/
/*******************************************/

/*******************************************/
/********* Dialog Constants Begin **********/
/*******************************************/

/*******************************************/
/********* Dialog Constants End ************/
/*******************************************/

/*******************************************/
/*********** App Bar Begin *****************/
/*******************************************/

// App Bar
const double kAppBarOuterPaddingTopFactor = 0.4;
const double kAppBarOuterPaddingBottomFactor = 0.24;
const double kAppBarOuterPaddingHorizontalFactor = 0.6;
const IconData kAppBarIcon = Icons.help_outline_outlined;
const double kAppBarIconSizeFactor = 1.2;
const Color kAppBarIconColor = Color.fromARGB(255, 255, 255, 255);
const double kAppBarTitleLeftPaddingFactor = 0.4;
const double kAppBarIconRightPaddingFactor = 1.0;
const Map<Language, String> kAppBarTitle = {
  Language.english: 'Profile',
  Language.turkish: 'Profil',
};
const String kAppBarTitleFontFamily = 'Sofia-Pro';
const double kAppBarTitleFontSizeFactor = 2.4;
const FontWeight kAppBarTitleFontWeight = FontWeight.w500;
const Color kAppBarTitleColor = Color.fromARGB(255, 250, 250, 250);

const Map<AppTheme, List<Color>> kAppBarBackgroundColor = {
  AppTheme.light: [
    /* Color.fromARGB(0, 29, 52, 255),
    Color.fromARGB(0, 10, 76, 218), */
    Color.fromARGB(255, 13, 71, 179),
    Color.fromARGB(255, 13, 71, 179),
  ],
  AppTheme.dark: [
    Color.fromARGB(255, 20, 20, 20),
    Color.fromARGB(255, 19, 19, 19)
  ],
};
const Color kAppBarShadowColor = Color.fromARGB(0, 0, 1, 56);
const double kAppBarShadowBlurRadiusFactor = 0.2;


/*******************************************/
/*********** App Bar End *******************/
/*******************************************/
