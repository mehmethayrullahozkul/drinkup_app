part of 'config_bloc.dart';

sealed class ConfigState extends Equatable {
  final Config config;
  const ConfigState({this.config = const Config()});
  @override
  List<Object> get props => [];
}

final class ConfigInitial extends ConfigState {
  const ConfigInitial();
}

final class ConfigLoaded extends ConfigState {
  const ConfigLoaded({required super.config});
  @override
  List<Object> get props => [config.language, config.appTheme];
}

final class ConfigError extends ConfigState {
  final String message;
  const ConfigError({this.message = ''});
  @override
  List<Object> get props => [message];
}
