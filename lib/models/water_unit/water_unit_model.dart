import 'package:hive/hive.dart';

part 'water_unit_24hour_model.dart';
part 'water_unit_model.g.dart';

@HiveType(typeId: 2)
class WaterUnit {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int amount;

  WaterUnit({
    DateTime? date,
    this.amount = 0,
  }) : date = date ?? DateTime.now();

  WaterUnit copyWith({
    DateTime? date,
    int? amount,
  }) {
    return WaterUnit(
      date: date ?? this.date,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() => 'WaterUnit(date: $date, amount: $amount)';
}
