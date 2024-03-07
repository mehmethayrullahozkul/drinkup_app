/* part of 'drinklist_bloc.dart';

sealed class DrinkListEvent {
  const DrinkListEvent();
}

final class DrinkListStarted extends DrinkListEvent {}

final class DrinkListChanged extends DrinkListEvent {
  final DrinkList drinks;
  const DrinkListChanged({required this.drinks});
}

final class DrinkListError extends DrinkListEvent {
  final String message;
  const DrinkListError({this.message = ''});
}

final class DrinkListRefresh extends DrinkListEvent {}

final class DrinkListAdd extends DrinkListEvent {
  final DrinkListItem drink;
  const DrinkListAdd({required this.drink});
}

final class DrinkListRemove extends DrinkListEvent {
  final DrinkListItem drink;
  const DrinkListRemove({required this.drink});
}
 */