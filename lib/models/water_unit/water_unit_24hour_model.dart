part of 'water_unit_model.dart';

class WaterUnit24Hour {
  int hour;
  int amount;

  WaterUnit24Hour({
    required this.hour,
    required this.amount,
  });

  WaterUnit24Hour copyWith({
    int? hour,
    int? amount,
  }) {
    return WaterUnit24Hour(
      hour: hour ?? this.hour,
      amount: amount ?? this.amount,
    );
  }

  void addAmount(int amount) {
    this.amount = this.amount + amount;
  }

  void subtractHour(int hour) {
    this.hour = this.hour - hour;
  }

  @override
  String toString() => 'WaterUnit24Hour(hour: $hour, amount: $amount)';
}
