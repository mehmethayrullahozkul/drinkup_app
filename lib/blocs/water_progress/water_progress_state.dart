part of 'water_progress_bloc.dart';

sealed class WaterProgressState extends Equatable {
  final int oldTarget;
  final int oldCurrent;
  final double oldProgress;
  final double progress;
  final int target;
  final int current;
  final double progressEndpoint;

  const WaterProgressState(
      {this.progress = 0.0,
      this.target = 0,
      this.current = 0,
      this.oldTarget = 0,
      this.oldCurrent = 0,
      this.oldProgress = 0.0,
      this.progressEndpoint = 0.0});
  @override
  List<Object> get props => [];
}

final class WaterProgressInitial extends WaterProgressState {
  const WaterProgressInitial();
}

final class WaterProgressLoaded extends WaterProgressState {
  const WaterProgressLoaded(
      {required super.progress,
      required super.target,
      required super.progressEndpoint,
      required super.current,
      required super.oldCurrent,
      required super.oldProgress,
      required super.oldTarget});
  @override
  List<Object> get props => [progress, target, current];
}

final class WaterProgressAtMax extends WaterProgressState {
  const WaterProgressAtMax({
    required super.progress,
    required super.target,
  });
  @override
  List<Object> get props => [progress, target];
}

final class WaterProgressError extends WaterProgressState {
  final String message;
  const WaterProgressError({this.message = ''});
  @override
  List<Object> get props => [message];
}
