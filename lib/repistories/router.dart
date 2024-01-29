import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:drinkup_app/blocs/network/network_bloc.dart';
import 'package:drinkup_app/login/login_page.dart';
import 'package:drinkup_app/screens/custom_styles/main_schema.dart';
import 'package:drinkup_app/screens/custom_styles/routes.dart';
import 'package:drinkup_app/screens/menu/main_menu.dart';
import '../blocs/auth/auth.dart';
import 'user.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import 'package:drinkup_app/screens/error/error_screen.dart';
import 'package:drinkup_app/screens/settings/settings.dart';
import 'package:drinkup_app/screens/profile/profile.dart';
import 'package:drinkup_app/screens/progress/progress.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class AppRouter {
  static GoRouter? router;
  static int index = Routes.login.index;

  static GoRouter initRouter(BuildContext context) {
    // Access bloc instances using context
    final AuthenticationBloc authBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    final UserRepository userRepistory =
        RepositoryProvider.of<UserRepository>(context);

    router = GoRouter(
        debugLogDiagnostics: true,
        initialLocation: Routes.menu.path,
        errorBuilder: (BuildContext context, GoRouterState state) =>
            const ErrorScreen(),
        routes: [
          GoRoute(
              name: Routes.menu.name,
              path: Routes.menu.path,
              builder: (BuildContext context, GoRouterState state) =>
                  MainSchema()),
          GoRoute(
            name: Routes.login.name,
            path: Routes.login.path,
            builder: (context, state) => LoginPage(),
          ),
          GoRoute(
              name: Routes.settings.name,
              path: Routes.settings.path,
              builder: (context, state) => SettingsScreen()),
          GoRoute(
              name: Routes.profile.name,
              path: Routes.profile.path,
              builder: (context, state) => ProfileScreen()),
          GoRoute(
              name: Routes.progress.name,
              path: Routes.progress.path,
              builder: (context, state) => ProgressScreen()),

          // Other routes

          // Other routes
        ],
        redirect: (BuildContext context, GoRouterState states) {
          print("redirecting");
          final bool loggedIn = AuthStreamScope.of(context).isSignedIn();
          final bool isLoginScreen =
              states.fullPath == Routes.login.path ? true : false;
          if (!loggedIn && !isLoginScreen) {
            print("redirect to login");
            index = Routes.login.index;
            return Routes.login.path;
          }
          if (loggedIn && isLoginScreen) {
            index = Routes.menu.index;
            print("redirect to menu");

            return Routes.menu.path;
          }
          print("no redirect");
          print(states.fullPath);
          print(loggedIn);
          print(isLoginScreen);
          if (states.fullPath == Routes.menu.path) {
            index = Routes.menu.index;
          } else if (states.fullPath == Routes.settings.path) {
            index = Routes.settings.index;
          } else if (states.fullPath == Routes.profile.path) {
            index = Routes.profile.index;
          } else if (states.fullPath == Routes.progress.path) {
            index = Routes.progress.index;
          }

          return null;
        });
    return router!;
  }
}
