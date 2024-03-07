import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/repositories/user/user_repository.dart';
import 'package:drinkup_app/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserInitial()) {
    on<AppStart>((event, emit) async {
      emit(const UserLoading());
      final bool hasUser = await userRepository.hasLocalUser();
      if (hasUser) {
        final User? user = await userRepository.loadLocalUser();
        emit(UserLoaded(user: user!));
      } else {
        emit(const UserInvalid());
      }
    });
    on<UserSetAnonymous>((event, emit) {
      emit(UserLoaded(user: AnonymousUser(username: event.username)));
    });
    on<UserSetAuthenticated>((event, emit) {
      emit(UserLoaded(
          user: AuthenticatedUser(mail: event.mail, username: event.username)));
    });
    on<UserSignOut>((event, emit) {
      emit(const UserInvalid());
    });
  }
}
