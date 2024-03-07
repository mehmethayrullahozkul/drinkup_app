import 'package:drinkup_app/models/water_unit/water_unit_model.dart';
import 'dart:math';
import 'package:drinkup_app/repositories/data/data_repository.dart';
import 'package:drinkup_app/models/water_data/water_data_model.dart';
import 'dart:async';

class WaterDataService {
  static const int MAX_WATER_AMOUNT = 8000;
  static const int MIN_WATER_ADD_AMOUNT = 100;
  static const int MAX_WATER_ADD_AMOUNT = 1000;

  late WaterData? _data;
  final List<WaterUnit> _units = [];
  bool _maxReached = false;

  WaterData get data => _data!;
  bool get hasWaterData => _data != null;
  int get waterUnitsCount => _units.length;
  List<WaterUnit> get units => _units;
  bool get atMax => _maxReached;

  late final DataRepository dataRepository;

  WaterDataService({required this.dataRepository});

  Future<void> load() async {
    _data = await dataRepository.getLocalLatestData();

    _data ??= WaterData();

    _maxReached = (_data!.amount == MAX_WATER_AMOUNT) ? true : false;

    _units.addAll(await dataRepository.getLocalLatestUnits());
  }

  Future<void> setWaterData({required WaterData waterData}) async {
    _data = waterData;
  }

  Future<void> saveWaterData({required WaterData waterData}) async {
    await dataRepository.saveLocalLatestData(waterData);
  }

  Future<void> addWaterUnit({required WaterUnit waterUnit}) async {
    _units.add(waterUnit);
    await dataRepository.addLocalWaterUnit(waterUnit);
  }

  Future<void> addWater({required int amount}) async {
    WaterData buffer = _data!;
    if (_data!.amount >= MAX_WATER_AMOUNT) {
      _maxReached = true;
      _data = WaterData(
          amount: MAX_WATER_AMOUNT,
          target: buffer.target,
          progress: (MAX_WATER_AMOUNT / buffer.target) * 100,
          isComplete: true);

      return;
    }

    if (_data!.amount + amount >= MAX_WATER_AMOUNT) {
      _maxReached = true;
      _data = WaterData(
          amount: MAX_WATER_AMOUNT,
          target: buffer.target,
          progress: (MAX_WATER_AMOUNT / buffer.target) * 100,
          isComplete: true);
      _units.add(WaterUnit(amount: max((MAX_WATER_AMOUNT - buffer.amount), 0)));
      await dataRepository.addLocalWaterUnit(
          WaterUnit(amount: (MAX_WATER_AMOUNT - buffer.amount)));
      await dataRepository.saveLocalLatestData(_data!);
      return;
    }
    print("not max, increasing");
    print(
        "amount: ${buffer.amount} , target: ${buffer.target}, added: $amount");
    _data = WaterData(
        amount: buffer.amount + amount,
        target: buffer.target,
        progress: ((buffer.amount + amount) / buffer.target) * 100,
        isComplete: ((buffer.amount + amount) >= buffer.target));
    final WaterUnit waterUnit = WaterUnit(amount: amount);
    _units.add(waterUnit);
    await dataRepository.addLocalWaterUnit(waterUnit);
    await dataRepository.saveLocalLatestData(_data!);
  }

  Future<void> clearWaterUnits() async {
    _units.clear();
    await dataRepository.deleteLocalLatestUnits();
  }

  Future<void> clearWaterData() async {
    _data = WaterData();
    await dataRepository.deleteLocalLatestData();
  }

  Future<void> clearAll() async {
    await clearWaterData();
    await clearWaterUnits();
  }

  List<WaterUnit> getUnitsByDate(DateTime date) {
    return _units
        .where((element) =>
            element.date.day == date.day &&
            element.date.month == date.month &&
            element.date.year == date.year)
        .toList();
  }

  List<WaterUnit> getLast24HoursUnits() {
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(const Duration(days: 1));
    return _units
        .where((element) =>
            element.date.isAfter(yesterday) && element.date.isBefore(now))
        .toList();
  }

  List<WaterUnit> getLast7DaysUnits() {
    final DateTime now = DateTime.now();
    final DateTime lastWeek = now.subtract(const Duration(days: 7));
    return _units
        .where((element) =>
            element.date.isAfter(lastWeek) && element.date.isBefore(now))
        .toList();
  }

  List<WaterUnit24Hour> getUnitsBy24Hour() {
    final List<WaterUnit> units = getLast24HoursUnits();
    final List<WaterUnit24Hour> result = [];
    /* List.filled(24, WaterUnit24Hour(hour: , amount: 0)); */
    for (int i = 0; i < 24; i++) {
      result.add(WaterUnit24Hour(hour: i, amount: 0));
    }
    int hour = 0;
    int index = 0;
    for (final WaterUnit unit in units) {
      hour = DateTime.now().difference(unit.date).inHours;
      /* result[23-hour] = WaterUnit24Hour(hour: 23-hour, amount: 0);
      } */
      result[23 - hour].addAmount(unit.amount);
    }
    for (int i = 1; i < 24; i++) {
      result[i].amount = result[i - 1].amount + result[i].amount;
    }

    return List.generate(
        12, (index) => result[/* 22 -  */ index * 2 + 1]..subtractHour(0));
  }

  int getUnitsBy24HourSum() {
    final List<WaterUnit> units = getLast24HoursUnits();
    int sum = 0;
    for (final WaterUnit unit in units) {
      sum += unit.amount;
    }
    return sum;
  }

  void sortUnits() {
    _units.sort((a, b) => a.date.compareTo(b.date));
  }

  Future<bool> refresh() async {
    try {
      _data = await dataRepository.getLocalLatestData();
      _units.clear();
      _units.addAll(await dataRepository.getLocalLatestUnits());
      sortUnits();
      print("refreshed, total units: ${getUnitsBy24HourSum()} ");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> hardRefresh() async {
    try {
      _data = await dataRepository.getLocalLatestData();
      await removeOldUnits();
      _units.clear();
      _units.addAll(await dataRepository.getLocalLatestUnits());
      sortUnits();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> removeOldUnits() async {
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(const Duration(days: 1));
    final List<WaterUnit> units =
        _units.where((element) => element.date.isBefore(yesterday)).toList();
    for (final WaterUnit unit in units) {
      _units.remove(unit);
      await dataRepository.deleteLocalWaterUnit(unit);
    }
  }

  Future<void> setTarget(int target) async {
    _data = WaterData(
        amount: _data!.amount,
        target: target,
        progress: (_data!.amount / target) * 100,
        isComplete: (_data!.amount >= target));
    await dataRepository.saveLocalLatestData(_data!);
  }
}
