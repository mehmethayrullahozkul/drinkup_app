import 'dart:ffi';

import 'package:drinkup_app/models/water_unit/water_unit_model.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:drinkup_app/models/config/config_model.dart';
import 'package:drinkup_app/constants/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:drinkup_app/models/water_data/water_data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ConfigRepository {
  static late String appDataDir;

  static Future<ConfigRepository> init() async {
    ConfigRepository configRepository = ConfigRepository();
    await configRepository.initialize();
    return configRepository;
  }

  Future<void> initialize() async {
    try {
      await setDirectory();
      if (Platform.isAndroid || Platform.isIOS) {
        await FlutterDisplayMode.setHighRefreshRate();
      }
      await Hive
        ..initFlutter(appDataDir)
        ..registerAdapter(WaterDataAdapter())
        ..registerAdapter(WaterUnitAdapter());

      final bool isConfigExists =
          await Hive.boxExists("config", path: appDataDir);
      if (!isConfigExists) {
        saveLocalConfigFile(config: const Config());
      }
    } catch (e) {
      print("ERROR: $e");
    }
    /* return this; */
  }

  Future<Config> getLocalConfig() async {
    try {
      var configBox = await Hive.openBox("config", path: appDataDir);
      return Config(
          appTheme: AppTheme.fromString(configBox.get("appTheme")),
          isHighRefreshRate: configBox.get("isHighRefreshRate"),
          isSplashScreenEnabled: configBox.get("isSplashScreenEnabled"),
          isFirstRun: configBox.get("isFirstRun"),
          language: Language.fromString(configBox.get("language")),
          appWaterUnit: AppWaterUnit.fromString(configBox.get("appWaterUnit")),
          timeFormat: TimeFormat.fromString(configBox.get("timeFormat")),
          reminderType: ReminderType.fromString(configBox.get("reminderType")),
          reminderInterval:
              ReminderInterval.fromString(configBox.get("reminderInterval")));
    } catch (e) {
      print(e);
    }
    return Config();
  }

  Future<void> setAppTheme(AppTheme AppTheme) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("appTheme", AppTheme.toString());
    await configBox.close();
  }

  Future<void> setHighRefreshRate(bool value) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("isHighRefreshRate", value);
    await configBox.close();
  }

  Future<void> setSplashScreenEnabled(bool value) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("isSplashScreenEnabled", value);
    await configBox.close();
  }

  Future<void> setFirstRun(bool value) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("isFirstRun", value);
    await configBox.close();
  }

  Future<void> setLanguage(Language language) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("language", language.toString());
    await configBox.close();
  }

  Future<void> setAppWaterUnit(AppWaterUnit appWaterUnit) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("appWaterUnit", appWaterUnit.toString());
    await configBox.close();
  }

  Future<void> setTimeFormat(TimeFormat timeFormat) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("timeFormat", timeFormat.toString());
    await configBox.close();
  }

  Future<void> setReminderType(ReminderType reminderType) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("reminderType", reminderType.toString());
    await configBox.close();
  }

  Future<void> setReminderInterval(ReminderInterval reminderInterval) async {
    final configBox = await Hive.openBox("config", path: appDataDir);
    configBox.put("reminderInterval", reminderInterval.toString());
    await configBox.close();
  }

  Future<void> dispose() async {
    /* await Hive.close(); */
  }

  Future<void> setDirectory() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    if (Platform.isWindows) {
      await Directory('${appDocDirectory.path}\\appdata')
          .create(recursive: true)
          .then((Directory directory) {
        appDataDir = directory.path;
      });
    } else if (Platform.isAndroid) {
      await Directory('${appDocDirectory.path}/appdata')
          .create(recursive: true)
          .then((Directory directory) {
        appDataDir = directory.path;
      });
    } else if (Platform.isIOS) {
      await Directory('${appDocDirectory.path}/appdata')
          .create(recursive: true)
          .then((Directory directory) {
        appDataDir = directory.path;
      });
    } else {
      await Directory('${appDocDirectory.path}/appdata')
          .create(recursive: true)
          .then((Directory directory) {
        appDataDir = directory.path;
      });
    }
  }

  Future<bool> saveLocalConfigFile({required Config config}) async {
    try {
      final configBox = await Hive.openBox("config", path: appDataDir);
      configBox.put("appTheme", config.appTheme.toString());
      configBox.put("isHighRefreshRate", config.isHighRefreshRate);
      configBox.put("isSplashScreenEnabled", config.isSplashScreenEnabled);
      configBox.put("isFirstRun", config.isFirstRun);
      configBox.put("language", config.language.toString());
      configBox.put("appWaterUnit", config.appWaterUnit.toString());
      configBox.put("timeFormat", config.timeFormat.toString());
      configBox.put("reminderType", config.reminderType.toString());
      configBox.put("reminderInterval", config.reminderInterval.toString());
      await configBox.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteLocalConfig() async {
    await Hive.deleteBoxFromDisk("config", path: appDataDir);
  }

  Future<void> setDataFiles() async {}

  Future<void> checkIntegrity() async {}
}
