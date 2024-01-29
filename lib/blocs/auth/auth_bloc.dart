import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/repistories/user.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'dart:async';
import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  //Profile({super.key, required this.username});
  //AuthenticationBloc({required this.userRepository}): assert(userRepository != null);

  final UserRepository userRepository;

  //@override
  //AuthenticationState get initialState => AuthenticationUninitialized();

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationUninitialized()) {
    on<AppStarted>((event, emit) async {
      print("App started");
      final bool hasToken = await userRepository.hasAccessToken();
      if (hasToken) {
        print("Has token");
        final bool authToken = /* await userRepository.auth(); */ true;
        if (authToken) {
          print("Token validated");
          emit(AuthenticationAuthenticated());
          FlutterNativeSplash.remove();
        } else {
          print("Token invalid");
          emit(AuthenticationUnauthenticated());
          FlutterNativeSplash.remove();
        }
      } else {
        print("No token");
        emit(AuthenticationUnauthenticated());
        FlutterNativeSplash.remove();
      }
    });
    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      await userRepository.saveAccessToken(event.token);
      emit(AuthenticationAuthenticated());
    });
    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await userRepository.logout();
      emit(AuthenticationUnauthenticated());
    });
  }
}

class AuthStreamScope extends InheritedNotifier<AuthStream> {
  final AuthStream authStream;

  AuthStreamScope({
    Key? key,
    required Widget child,
    required AuthenticationBloc authBloc,
    required UserRepository userRepository,
  })  : authStream = AuthStream(authBloc.stream, authBloc, userRepository),
        super(
          key: key,
          notifier: AuthStream(authBloc.stream, authBloc, userRepository),
          child: child,
        );

  static AuthStream of(BuildContext ctx) =>
      ctx.dependOnInheritedWidgetOfExactType<AuthStreamScope>()!.authStream;
}

class AuthStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;
  final AuthenticationBloc authBloc;
  AuthenticationState _oldState;

  AuthStream(
    Stream<dynamic> stream,
    this.authBloc,
    UserRepository userRepository,
  )   : _oldState = authBloc.state,
        super() {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_notifyAuthListener));
  }

  void _notifyAuthListener(dynamic event) {
    print(authBloc.state.toString());
    print(_oldState.toString());
    if (!(authBloc.state == _oldState)) {
      if (authBloc.state is AuthenticationAuthenticated ||
          authBloc.state is AuthenticationUnauthenticated) {
        _oldState = authBloc.state;
        notifyListeners();
      }
    }
  }

  bool isSignedIn() {
    return authBloc.state is AuthenticationAuthenticated ? true : false;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
