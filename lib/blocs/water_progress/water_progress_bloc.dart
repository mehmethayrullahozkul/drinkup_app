import 'package:drinkup_app/services/water_data/water_data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
part 'water_progress_state.dart';
part 'water_progress_event.dart';

class WaterProgressBloc extends Bloc<WaterProgressEvent, WaterProgressState> {
  final WaterDataService waterDataService;

  WaterProgressBloc({required this.waterDataService})
      : super(const WaterProgressInitial()) {
    on<WaterProgressStarted>((event, emit) async {
      Constants.developerLog("STATUS: WaterProgressStarted event received");
      emit(const WaterProgressInitial());
      await waterDataService.load();
      Constants.developerLog("SUCCESS: WaterDataService loaded");
      emit(WaterProgressLoaded(
          progress: waterDataService.data.progress,
          target: waterDataService.data.target,
          current: waterDataService.data.amount,
          progressEndpoint: (waterDataService.data.progress -
                  (waterDataService.data.progress % 100)) +
              100,
          oldCurrent: state.current,
          oldProgress: state.progress,
          oldTarget: state.target));
    });
    on<WaterProgressChanged>((event, emit) {
      emit(WaterProgressLoaded(
        oldCurrent: state.current,
        oldProgress: state.progress,
        oldTarget: state.oldTarget,
        progressEndpoint: (waterDataService.data.progress -
                (waterDataService.data.progress % 100)) +
            100,
        progress: event.progress,
        target: event.target,
        current: event.current,
      ));
    });
    on<WaterProgressMaxReached>((event, emit) async {
      emit(WaterProgressAtMax(progress: event.progress, target: event.target));
    });
    on<WaterProgressIncreased>((event, emit) async {
      await waterDataService.addWater(amount: event.amount);

      if (waterDataService.atMax) {
        if (state is! WaterProgressAtMax) {
          emit(WaterProgressLoaded(
              progress: waterDataService.data.progress,
              target: waterDataService.data.target,
              current: waterDataService.data.amount,
              progressEndpoint: (waterDataService.data.progress -
                      (waterDataService.data.progress % 100)) +
                  100,
              oldCurrent: state.current,
              oldProgress: state.progress,
              oldTarget: state.target));
        } else {
          emit(WaterProgressAtMax(
              progress: waterDataService.data.progress,
              target: waterDataService.data.target));
        }
      } else {
        emit(WaterProgressLoaded(
            progress: waterDataService.data.progress,
            target: waterDataService.data.target,
            current: waterDataService.data.amount,
            progressEndpoint: (waterDataService.data.progress -
                    (waterDataService.data.progress % 100)) +
                100,
            oldCurrent: state.current,
            oldProgress: state.progress,
            oldTarget: state.target));
      }
    });
  }
}
