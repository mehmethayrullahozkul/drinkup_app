part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class AppStart extends UserEvent {
  const AppStart();
  @override
  List<Object> get props => [];
}

class UserStarted extends UserEvent {
  const UserStarted();
  @override
  List<Object> get props => [];
}

class UserSignOut extends UserEvent {
  const UserSignOut();
  @override
  List<Object> get props => [];
}

class UserSetUser extends UserEvent {
  final User? user;
  const UserSetUser({required this.user});
  @override
  List<Object> get props => [user!];
}

class UserSetAnonymous extends UserEvent {
  final String username;
  const UserSetAnonymous({required this.username});
  @override
  List<Object> get props => [username];
}

class UserSetAuthenticated extends UserEvent {
  final String username;
  final String mail;
  const UserSetAuthenticated({required this.username, required this.mail});
  @override
  List<Object> get props => [username, mail];
}
