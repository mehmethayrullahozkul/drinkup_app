part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final User user;
  const UserState({this.user = const AnonymousUser(username: 'Anonymous')});

  @override
  List<Object> get props => [user];
}

class UserInitial extends UserState {
  const UserInitial();
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  const UserLoading();
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  const UserLoaded({required super.user});
  @override
  List<Object> get props => [user];
}

class UserInvalid extends UserState {
  const UserInvalid();
  @override
  List<Object> get props => [];
}

class UserError extends UserState {
  final String message;
  const UserError({required this.message});
  @override
  List<Object> get props => [message];
}
