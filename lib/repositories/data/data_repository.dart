import 'package:drinkup_app/models/water_unit/water_unit_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:drinkup_app/models/water_data/water_data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DataRepository {
  static late String appDataDir;

  static Future<DataRepository> init() async {
    DataRepository dataRepository = DataRepository();
    await dataRepository.initialize();
    return dataRepository;
  }

  Future<void> initialize() async {
    try {
      await setDirectory();
      final bool isLatestDataExist =
          await Hive.boxExists("latest-data", path: appDataDir);

      print("Latest data exists: $isLatestDataExist");
      if (!isLatestDataExist) {
        print("Creating latest data file");
        await createLatesDataFile();
      }

      final bool isLatestUnitsExists =
          await Hive.boxExists("latest-units", path: appDataDir);

      if (!isLatestUnitsExists) {
        await createLatestUnitsFile();
      }

      final bool isDataLogsExists =
          await Hive.boxExists("data-logs", path: appDataDir);

      if (!isDataLogsExists) {
        await createDataLogsFile();
      }
      await Hive.openBox<WaterData>("latest-data", path: appDataDir);
      await Hive.openBox<WaterUnit>("latest-units", path: appDataDir);
      await Hive.openBox<WaterData>("data-logs", path: appDataDir);
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Future<WaterData?> getLocalLatestData() async {
    final box = await Hive.openBox<WaterData>("latest-data", path: appDataDir);
    final WaterData? latest = box.get("water-data");
    if (latest != null) latest.safe();
    return latest;
  }

  Future<List<WaterUnit>> getLocalLatestUnits() async {
    final box = await Hive.openBox<WaterUnit>("latest-units", path: appDataDir);
    final List<WaterUnit> latest =
        (box.values.isNotEmpty) ? box.values.toList().cast<WaterUnit>() : [];
    return latest;
  }

  Future<void> saveLocalLatestData(WaterData data) async {
    final box = await Hive.openBox<WaterData>("latest-data", path: appDataDir);
    await box.put("water-data", data);
  }

  Future<bool> createLatesDataFile() async {
    try {
      final latestDataBox =
          await Hive.openBox<WaterData>("latest-data", path: appDataDir);
      await latestDataBox.put("water-data", WaterData());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createLatestUnitsFile() async {
    try {
      await Hive.openBox<WaterUnit>("latest-units", path: appDataDir);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createDataLogsFile() async {
    try {
      await Hive.openBox<WaterData>("data-logs", path: appDataDir);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> resetLocalLatestData() async {
    final box = await Hive.openBox<WaterData>("latest-data", path: appDataDir);
    await box.deleteAll(box.keys);
    await box.put("water-data", WaterData());
  }

  Future<void> resetLocalLatestUnits() async {
    final box = await Hive.openBox<WaterUnit>("latest-units", path: appDataDir);
    await box.deleteAll(box.keys);
  }

  Future<void> resetLocalDataLogs() async {
    final box = await Hive.openBox<WaterData>("data-logs", path: appDataDir);
    await box.deleteAll(box.keys);
  }

  Future<void> resetLocalAll() async {
    await resetLocalLatestData();
    await resetLocalLatestUnits();
    await resetLocalDataLogs();
  }

  Future<void> deleteLocalAll() async {
    await Hive.deleteBoxFromDisk("latest-units", path: appDataDir);
    await Hive.deleteBoxFromDisk("latest-data", path: appDataDir);
    await Hive.deleteBoxFromDisk("data-logs", path: appDataDir);
  }

  Future<void> deleteLocalLatestData() async {
    await Hive.deleteBoxFromDisk("latest-data", path: appDataDir);
  }

  Future<void> deleteLocalLatestUnits() async {
    await Hive.deleteBoxFromDisk("latest-units", path: appDataDir);
  }

  Future<void> deleteLocalDataLogs() async {
    await Hive.deleteBoxFromDisk("data-logs", path: appDataDir);
  }

  Future<void> addLocalDataLog(WaterData data) async {
    final box = await Hive.openBox<WaterData>("data-logs", path: appDataDir);
    await box.add(data);
  }

  Future<void> addLocalWaterUnit(WaterUnit unit) async {
    final box = await Hive.openBox<WaterUnit>("latest-units", path: appDataDir);
    await box.add(unit);
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

  Future<void> dispose() async {
    await Hive.close();
  }

  Future<void> deleteLocalWaterUnit(WaterUnit unit) async {
    final box = await Hive.openBox<WaterUnit>("latest-units", path: appDataDir);
    await box.deleteAt(box.values.toList().indexOf(unit));
  }
}
