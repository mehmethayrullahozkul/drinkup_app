/* import 'package:drinkup_app/screens/menu/drinklist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'drinklist_state.dart';
part 'drinklist_event.dart';

class DrinkListBloc extends Bloc<DrinkListEvent, DrinkListState> {
  DrinkListBloc() : super(DrinkListInitial()) {
    on<DrinkListStarted>((event, emit) {
      emit(DrinkListLoading());
      emit(const DrinkListLoaded(
        drinks: DrinkList(items: []),
      ));
    });
    on<DrinkListChanged>((event, emit) {
      emit(DrinkListLoaded(
        drinks: event.drinks,
      ));
    });
    on<DrinkListError>((event, emit) {
      emit(const DrinkListLoaded(
        drinks: DrinkList(items: []),
      ));
    });
    on<DrinkListRefresh>((event, emit) {
      emit(DrinkListLoading());
      emit(DrinkListLoaded(
        drinks: DrinkList(items: state.drinks.items),
      ));
    });
    on<DrinkListAdd>((event, emit) {
      final DrinkListState currentState = state;
      if (currentState is DrinkListLoaded) {
        currentState.drinks.items.add(event.drink);
        emit(DrinkListLoaded(
          drinks: currentState.drinks,
        ));
      }
    });
    on<DrinkListRemove>((event, emit) {
      final DrinkListState currentState = state;
      if (currentState is DrinkListLoaded) {
        currentState.drinks.items.remove(event.drink);
        emit(DrinkListLoaded(
          drinks: currentState.drinks,
        ));
      }
    });
  }
}
 */