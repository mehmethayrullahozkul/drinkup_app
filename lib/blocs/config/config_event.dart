part of 'config_bloc.dart';

sealed class ConfigEvent {
  const ConfigEvent();
}

final class ConfigStarted extends ConfigEvent {}

final class ConfigChanged extends ConfigEvent {
  final Config config;
  const ConfigChanged({required this.config});
}
