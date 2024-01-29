import 'package:drinkup_app/blocs/network/network_bloc.dart';
import 'package:drinkup_app/login/login_page.dart';
import 'package:drinkup_app/screens/menu/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth.dart';
import 'package:go_router/go_router.dart';
import 'blocs/auth/auth_bloc.dart';
import 'package:drinkup_app/repistories/storage.dart';
import 'repistories/router.dart';
import 'repistories/user.dart';
import 'package:drinkup_app/screens/error/error_screen.dart';
import 'package:drinkup_app/screens/settings/settings.dart';
import 'package:drinkup_app/screens/profile/profile.dart';
import 'package:drinkup_app/screens/progress/progress.dart';
import 'package:drinkup_app/screens/custom_styles/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await FlutterDisplayMode.setHighRefreshRate();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Storage.initStorage();
  Bloc.observer = SimpleBlocObserver();
  final finalUserRepository = UserRepository();
  runApp(MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => finalUserRepository)],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) =>
                AuthenticationBloc(userRepository: finalUserRepository)
                  ..add(AppStarted())),
        BlocProvider<NetworkBloc>(
            create: (BuildContext context) => NetworkBloc())
      ], child: MyApp(/* userRepository: finalUserRepository */))));
}

class MyApp extends StatelessWidget {
  //late final UserRepository userRepository;

  //MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    //userRepository = RepositoryProvider.of<UserRepository>(context);
    final GoRouter myRouter = AppRouter.initRouter(context);
    return AuthStreamScope(
      authBloc: BlocProvider.of<AuthenticationBloc>(context),
      userRepository: RepositoryProvider.of<UserRepository>(context),
      child: MaterialApp.router(routerConfig: myRouter),
    );
  }
}



  //@override
  //Widget build(BuildContext context) {
  //  return MaterialApp(
  //    debugShowCheckedModeBanner: false,
  //    locale: const Locale('mn', 'MN'),
  //    theme: ThemeData(
  //      fontFamily: 'Rubik',
  //      primarySwatch: Colors.blueGrey,
  //    ),
  //    home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
  //      builder: (context, state) {
  //        if (state is AuthenticationAuthenticated) {
  //          return MainScreen();
  //        }
  //        if (state is AuthenticationUnauthenticated) {
  //          return LoginPage(userRepistory: userRepository);
  //        }
  //        if (state is AuthenticationLoading) {
  //          return Scaffold(
  //            body: Container(
  //              color: Colors.white,
  //              width: MediaQuery.of(context).size.width,
  //              child: Column(
  //                crossAxisAlignment: CrossAxisAlignment.center,
  //                mainAxisAlignment: MainAxisAlignment.center,
  //                children: <Widget>[
  //                  SizedBox(
  //                    height: 25.0,
  //                    width: 25.0,
  //                    child: CircularProgressIndicator(
  //                      valueColor:
  //                          new AlwaysStoppedAnimation<Color>(Colors.white),
  //                      strokeWidth: 4.0,
  //                    ),
  //                  )
  //                ],
  //              ),
  //            ),
  //          );
  //        }
  //        return Scaffold(
  //          body: Container(
  //            color: Colors.white,
  //            width: MediaQuery.of(context).size.width,
  //            child: Column(
  //              crossAxisAlignment: CrossAxisAlignment.center,
  //              mainAxisAlignment: MainAxisAlignment.center,
  //              children: <Widget>[
  //                SizedBox(
  //                  height: 25.0,
  //                  width: 25.0,
  //                  child: CircularProgressIndicator(
  //                    valueColor:
  //                        new AlwaysStoppedAnimation<Color>(Colors.white),
  //                    strokeWidth: 4.0,
  //                  ),
  //                )
  //              ],
  //            ),
  //          ),
  //        );
  //      },
  //    ),
  //  );
  //}


/*

import 'package:flutter/material.dart';
import 'login/login_page.dart';
import 'package:go_router/go_router.dart';
import 'screens/error/error_screen.dart';
import 'screens/menu/main_menu.dart';
import 'screens/settings/settings.dart';
import 'screens/profile/game.dart';
import 'utils/router_names.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Our Go Router App',
      routerConfig: _router,
    );
  }

  // in default inital location is '/'
  // but can change the initial location with initialLocation: in GoRouter
  final GoRouter _router = GoRouter(
      errorBuilder: (context, state) => const ErrorScreen(),
      // redirect: (context, state) {
      //   if (isLoggedIn) {
      //     return "/menu";
      //   } else {
      //     return "/";
      //   }
      // },
      routes: [
        GoRoute(
            name: RouteNames.login,
            path: '/',
            builder: (context, state) => const LoginPage(),
            routes: [
              GoRoute(
                  name: RouteNames.menu,
                  path: 'menu',
                  builder: (context, state) => const MainMenu()),
              GoRoute(
                  name: RouteNames.settings,
                  path: 'settings',
                  builder: (context, state) => const SettingsScreen()),
              GoRoute(
                  name: RouteNames.profile,
                  path: 'profile/:username',
                  builder: (context, state) => Profile(
                      username: state.pathParameters["username"]!)),
            ]),
      ]);
}

*/

