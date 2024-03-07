part of 'water_progress_bloc.dart';

sealed class WaterProgressEvent {
  const WaterProgressEvent();
}

final class WaterProgressStarted extends WaterProgressEvent {}

final class WaterProgressChanged extends WaterProgressEvent {
  final double progress;
  final int target;
  final int current;
  const WaterProgressChanged(
      {required this.progress, required this.target, required this.current});
}

final class WaterProgressIncreased extends WaterProgressEvent {
  final int amount;
  const WaterProgressIncreased({required this.amount});
}

final class WaterProgressMaxReached extends WaterProgressEvent {
  final double progress;
  final int target;

  const WaterProgressMaxReached({required this.progress, required this.target});
}
