import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:drinkup_app/services/config/config_service.dart';
import 'package:drinkup_app/models/config/config_model.dart';
import 'package:drinkup_app/repositories/config/config_repository.dart';

part 'config_state.dart';
part 'config_event.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final ConfigService configService;

  ConfigBloc({required this.configService}) : super(const ConfigInitial()) {
    on<ConfigStarted>((event, emit) async {
      emit(const ConfigInitial());
      await configService.load();
      emit(ConfigLoaded(config: configService.config));
    });
    on<ConfigChanged>((event, emit) {
      emit(ConfigLoaded(config: event.config));
    });
  }
}
