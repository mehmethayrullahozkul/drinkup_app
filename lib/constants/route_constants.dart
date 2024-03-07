class Routes {
  const Routes._();
  static const _Route menu = _Route(name: "menu", path: "/menu", index: 0);
  static const _Route login = _Route(name: "login", path: "/login", index: -1);

  static const _Route history =
      _Route(name: "history", path: "/history", index: 1);

  static const _Route progress =
      _Route(name: "progress", path: "/progress", index: 2);
  static const _Route profile =
      _Route(name: "profile", path: "/profile", index: 3);

  static const _Route settings =
      _Route(name: "settings", path: "/settings", index: 1000);

  static const _Route addWaterDialog =
      _Route(name: "add-water", path: "add-water", index: 1001);
  static const _Route changeThemeDialog =
      _Route(name: "theme", path: "theme", index: 1002);
  static const _Route changeLanguageDialog =
      _Route(name: "language", path: "language", index: 1002);
  static const _Route changeWaterUnitDialog =
      _Route(name: "water-unit", path: "water-unit", index: 1003);
  static const _Route changeTimeFormatDialog =
      _Route(name: "time-format", path: "time-format", index: 1005);
  static const _Route changeDailyGoalDialog =
      _Route(name: "daily-goal", path: "daily-goal", index: 1006);
  static const _Route changeReminderTypeDialog =
      _Route(name: "reminder-type", path: "reminder-type", index: 1007);
  static const _Route changeReminderIntervalDialog =
      _Route(name: "reminder-interval", path: "reminder-interval", index: 11);
  static const _Route error = _Route(name: "error", path: "/error", index: 12);
  static const _Route splash =
      _Route(name: "splash", path: "/splash", index: 13);
  static const _Route onboarding =
      _Route(name: "onboarding", path: "/onboarding", index: 14);
  static const _Route welcome =
      _Route(name: "welcome", path: "/welcome", index: 15);
  static const _Route register =
      _Route(name: "register", path: "/register", index: 16);
  static const _Route forgotPassword =
      _Route(name: "forgot-password", path: "/forgot-password", index: 17);
  static const _Route resetPassword =
      _Route(name: "reset-password", path: "/reset-password", index: 18);
  static const _Route verifyEmail =
      _Route(name: "verify-email", path: "/verify-email", index: 19);
  static const _Route verifyPhone =
      _Route(name: "verify-phone", path: "/verify-phone", index: 20);
}

/* class RouteNames {
  static const String menu = "menu";
  static const String login = "login";
  static const String profile = "profile";
  static const String settings = "settings";
  static const String progress = "progress";
  static const String addWaterDialog = "add-water";
  static const String changeThemeDialog = "theme";
  static const String changeLanguageDialog = "language";
  static const String changeWaterUnitDialog = "water-unit";
  static const String changeTimeFormatDialog = "time-format";
  static const String changeDailyGoalDialog = "daily-goal";
  static const String changeReminderTypeDialog = "reminder-type";
  static const String changeReminderIntervalDialog = "reminder-interval";
  static const String error = "error";
}

class RouteIndexes {
  static const int menu = 0;
  static const int login = -1;
  static const int profile = 1;
  static const int settings = 2;
  static const int progress = 3;
  static const int addWaterDialog = 4;
  static const int changeThemeDialog = 5;
  static const int changeLanguageDialog = 6;
  static const int changeWaterUnitDialog = 7;
  static const int changeTimeFormatDialog = 8;
  static const int changeDailyGoalDialog = 9;
}

class RoutePaths {
  static const String menu = "/menu";
  static const String login = "/login";
  static const String profile = "/profile";
  static const String settings = "/settings";
  static const String progress = "/progress";
} */

class _Route {
  final String name;
  final String path;
  final int index;

  const _Route({required this.name, required this.path, required this.index});
}
