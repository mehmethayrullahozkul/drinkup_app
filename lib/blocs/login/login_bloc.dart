import 'package:drinkup_app/blocs/network/network.dart';
import 'package:drinkup_app/repositories/user/user_repository.dart';
import 'package:drinkup_app/services/authentication/authentication_service.dart';
import 'package:drinkup_app/services/user/user_service.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:drinkup_app/models/user/user_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({
    required this.userRepository,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      var hasInternet = await NetworkBloc().hasInternet();
      if (!hasInternet) {
        emit(const LoginFailure(error: "Has no internet access."));
        return;
      }
      emit(LoginLoading());
      print("login button pressed");

      final User lUser = await AuthenticationService().signIn(
          username: event.username, password: event.password, anonymous: false);

      if (!lUser.valid) {
        emit(const LoginFailure(error: "Invalid credentials"));
      } else {
        emit(LoginSuccess());
      }
    });
    on<AnonymousLoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      print("anon login button pressed");

      final User user = await AuthenticationService()
          .signIn(username: event.username, password: '', anonymous: true);

      if (!user.valid) {
        emit(const LoginFailure(error: "Invalid credentials"));
      } else {
        UserService().setUser(user: user);
        UserService().saveUser(user: user);
        emit(LoginSuccess());
      }
      /* emit(LoginLoading());
      final validate = await userRepository.login(
          credentials: LoginCredentials(username: event.username, password: ''),
          isAnonymus: true);
      if (!validate) {
        emit(const LoginFailure(error: "Invalid credentials"));
      } else {
        authenticationBloc.add(AnonymousLoggedIn(
            credentials:
                LoginCredentials(username: event.username, password: '')));
      } */
    });
  }
}
