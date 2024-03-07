import 'package:drinkup_app/repositories/config/config_repository.dart';
import 'package:drinkup_app/models/config/config_model.dart';
import 'package:drinkup_app/constants/constants.dart';

import 'dart:async';

class ConfigService {
  late Config? _config;

  Config get config => _config!;

  late final ConfigRepository configRepository;

  ConfigService({required this.configRepository});

  Future<void> load() async {
    /* _config = await configRepository.getConfig(); */

    _config /* ?? */ = Config(appTheme: AppTheme.light);
  }

  Future<void> setConfig({required Config config}) async {
    _config = config;
  }

  Future<void> saveConfig({required Config config}) async {
    await configRepository.saveLocalConfigFile(config: config);
  }

  Future<void> setAppTheme({required AppTheme AppTheme}) async {
    _config = _config!.copyWith(newAppTheme: AppTheme);
    await configRepository.saveLocalConfigFile(config: _config!);
  }

  Future<void> setHighRefreshRate({required bool value}) async {
    _config = _config!.copyWith(newIsHighRefreshRate: value);
    await configRepository.saveLocalConfigFile(config: _config!);
  }

  Future<void> resetConfig() async {
    _config = const Config();
    await configRepository.deleteLocalConfig();
  }

  Future<void> setLanguage({required Language language}) async {
    _config = _config!.copyWith(newLanguage: language);
    await configRepository.saveLocalConfigFile(config: _config!);
  }

  Future<void> setWaterUnit({required AppWaterUnit appWaterUnit}) async {
    _config = _config!.copyWith(newAppWaterUnit: appWaterUnit);
    await configRepository.saveLocalConfigFile(config: _config!);
  }

  Future<void> setTimeFormat({required TimeFormat timeFormat}) async {
    _config = _config!.copyWith(newTimeFormat: timeFormat);
    await configRepository.saveLocalConfigFile(config: _config!);
  }

  Future<void> setReminderType({required ReminderType reminderType}) async {
    _config = _config!.copyWith(newReminderType: reminderType);
    await configRepository.saveLocalConfigFile(config: _config!);
  }

  Future<void> setReminderInterval(
      {required ReminderInterval reminderInterval}) async {
    _config = _config!.copyWith(newReminderInterval: reminderInterval);
    await configRepository.saveLocalConfigFile(config: _config!);
  }
}
