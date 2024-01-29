import 'package:drinkup_app/blocs/auth/auth.dart';
import 'package:drinkup_app/blocs/network/network.dart';
import 'package:drinkup_app/repistories/user.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      var hasInternet = await NetworkBloc().hasInternet();
      if (!hasInternet) {
        emit(LoginFailure(error: "Has no internet access."));
        return;
      }
      emit(LoginLoading());
      print("login button pressed");
      authenticationBloc.add(LoggedIn(token: 'mynewtoken'));
      //try {
      //  final token =
      //      await userRepository.login(event.username, event.password);
      //  authenticationBloc.add(LoggedIn(token: token));
      //  emit(LoginInitial());
      //} catch (error) {
      //  emit(LoginFailure(error: error.toString()));
      //}
    });
  }

  //@override
  //LoginState get initialState => LoginInitial();

  //@override
  //Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //  if (event is LoginButtonPressed) {
  //    yield LoginLoading();
//
  //    try {
  //      final token = await userRepository.login(
  //        event.username,
  //        event.password,
  //      );
  //      authenticationBloc.add(LoggedIn(token: token));
  //      yield LoginInitial();
  //    } catch (error) {
  //      yield LoginFailure(error: error.toString());
  //    }
  //  }
  //}
}
