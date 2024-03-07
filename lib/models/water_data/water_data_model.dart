import 'package:hive/hive.dart';

part 'water_data_model.g.dart';

@HiveType(typeId: 1)
class WaterData {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int target;

  @HiveField(2)
  double progress;

  @HiveField(3)
  int amount;

  @HiveField(4)
  bool isComplete;

  WaterData({
    DateTime? date,
    this.target = 2000,
    this.progress = 0.0,
    this.amount = 0,
    this.isComplete = false,
  }) : date = date ?? DateTime.now();

  WaterData copyWith({
    DateTime? date,
    int? target,
    double? progress,
    int? amount,
    bool? isComplete,
  }) {
    return WaterData(
      date: date ?? this.date,
      target: target ?? this.target,
      progress: progress ?? this.progress,
      amount: amount ?? this.amount,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  void safe() {
    if (progress.isNaN || progress.isInfinite || progress.isNegative) {
      progress = 0.0;
    }
    if (amount.isNaN || amount.isInfinite || amount.isNegative) {
      amount = 0;
    }
    if (target.isNaN || target.isInfinite || target.isNegative) {
      target = 2000;
    }
  }

  @override
  String toString() {
    return 'WaterData(date: $date, target: $target, progress: $progress, amount: $amount, isComplete: $isComplete)';
  }
}
