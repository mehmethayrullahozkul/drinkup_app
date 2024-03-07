/* part of 'drinklist_bloc.dart';

sealed class DrinkListState extends Equatable {
  final DrinkList drinks;
  const DrinkListState({this.drinks = const DrinkList(items: [])});
  @override
  List<Object> get props => [];
}

final class DrinkListInitial extends DrinkListState {}

final class DrinkListLoading extends DrinkListState {}

final class DrinkListLoaded extends DrinkListState {
  const DrinkListLoaded({required super.drinks});
  @override
  List<Object> get props => [drinks];
}
 */