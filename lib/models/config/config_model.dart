import 'package:drinkup_app/constants/constants.dart';

class Config {
  final AppTheme appTheme;
  final bool isHighRefreshRate;
  final bool isSplashScreenEnabled;
  final bool isFirstRun;
  final Language language;
  final AppWaterUnit appWaterUnit;
  final TimeFormat timeFormat;
  final ReminderInterval reminderInterval;
  final ReminderType reminderType;
  final String appDataDir;

  const Config(
      {this.appTheme = AppTheme.light,
      this.isHighRefreshRate = true,
      this.isSplashScreenEnabled = true,
      this.isFirstRun = true,
      this.language = Language.english,
      this.appWaterUnit = AppWaterUnit.ml,
      this.timeFormat = TimeFormat.twentyfour,
      this.reminderType = ReminderType.notification,
      this.reminderInterval = ReminderInterval.hourly,
      this.appDataDir = ''});

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      appTheme: AppTheme.fromString(json['appTheme']),
      isHighRefreshRate: json['isHighRefreshRate'],
      isSplashScreenEnabled: json['isSplashScreenEnabled'],
      isFirstRun: json['isFirstRun'],
      language: Language.fromString(json['language']),
      appWaterUnit: AppWaterUnit.fromString(json['appWaterUnit']),
      timeFormat: TimeFormat.fromString(json['timeFormat']),
      reminderType: ReminderType.fromString(json['reminderType']),
      reminderInterval: ReminderInterval.fromString(json['reminderInterval']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AppTheme': appTheme.toString(),
      'isHighRefreshRate': isHighRefreshRate,
      'isSplashScreenEnabled': isSplashScreenEnabled,
      'isFirstRun': isFirstRun,
      'language': language.toString(),
      'appWaterUnit': appWaterUnit.toString(),
      'timeFormat': timeFormat.toString(),
      'reminderType': reminderType.toString(),
      'reminderInterval': reminderInterval.toString(),
    };
  }

  Config copyWith({
    AppTheme? newAppTheme,
    bool? newIsHighRefreshRate,
    bool? newIsSplashScreenEnabled,
    bool? newIsFirstRun,
    Language? newLanguage,
    AppWaterUnit? newAppWaterUnit,
    TimeFormat? newTimeFormat,
    ReminderType? newReminderType,
    ReminderInterval? newReminderInterval,
  }) {
    return Config(
      appTheme: newAppTheme ?? appTheme,
      isHighRefreshRate: newIsHighRefreshRate ?? isHighRefreshRate,
      isSplashScreenEnabled: newIsSplashScreenEnabled ?? isSplashScreenEnabled,
      isFirstRun: newIsFirstRun ?? isFirstRun,
      language: newLanguage ?? language,
      appWaterUnit: newAppWaterUnit ?? appWaterUnit,
      timeFormat: newTimeFormat ?? timeFormat,
      reminderType: newReminderType ?? reminderType,
      reminderInterval: newReminderInterval ?? reminderInterval,
    );
  }
}
