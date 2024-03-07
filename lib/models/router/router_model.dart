import 'package:drinkup_app/screens/dialogs/change_language_dialog.dart';
import 'package:drinkup_app/screens/dialogs/menu_addwater_dialog.dart';
import 'package:drinkup_app/screens/dialogs/dialog_page_wrap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:drinkup_app/blocs/water_progress/water_progress_bloc.dart';
import 'package:drinkup_app/screens/login/login_page.dart';
import 'package:drinkup_app/screens/schemas/screen_draft.dart';
import 'package:drinkup_app/screens/settings/settings.dart';
import 'package:drinkup_app/constants/route_constants.dart';
import '../../blocs/auth/auth.dart';
import '../../repositories/user/user_repository.dart';
import 'package:drinkup_app/screens/dialogs/profile_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:drinkup_app/screens/error/error_screen.dart';

class AppRouter {
  static GoRouter? router;
  static int index = Routes.menu.index;

  static final AppRouter _singleton = AppRouter._internal();

  AppRouter._internal();

  factory AppRouter() {
    return _singleton;
  }

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
                  const MainSchema(),
              routes: [
                // Change Language
                GoRoute(
                    name: Routes.changeLanguageDialog.name,
                    path: Routes.changeLanguageDialog.path,
                    pageBuilder: (context, state) {
                      return const DialogPageWrap(
                          child: ChangeLanguageDialog(),
                          forwardAnimationDurationInMilliseconds: 300,
                          reverseAnimationDurationInMilliseconds: 100,
                          animationType: DialogAnimationType.fade);
                    }),
                // Add Water
                GoRoute(
                    name: Routes.addWaterDialog.name,
                    path: Routes.addWaterDialog.path,
                    pageBuilder: (context, state) {
                      return const DialogPageWrap(
                          child: AddWaterDialog(),
                          forwardAnimationDurationInMilliseconds: 500,
                          reverseAnimationDurationInMilliseconds: 500,
                          animationType: DialogAnimationType.slidefrombottom);
                    }),
                // Change Theme
                GoRoute(
                    name: Routes.changeThemeDialog.name,
                    path: Routes.changeThemeDialog.path,
                    pageBuilder: (context, state) {
                      return CustomDialog();
                    }),
                // Change Water Unit
                GoRoute(
                    name: Routes.changeWaterUnitDialog.name,
                    path: Routes.changeWaterUnitDialog.path,
                    pageBuilder: (context, state) {
                      return CustomDialog();
                    }),
                // Change Time Format
                GoRoute(
                    name: Routes.changeTimeFormatDialog.name,
                    path: Routes.changeTimeFormatDialog.path,
                    pageBuilder: (context, state) {
                      return CustomDialog();
                    }),
                // Change Daily Goal
                GoRoute(
                    name: Routes.changeDailyGoalDialog.name,
                    path: Routes.changeDailyGoalDialog.path,
                    pageBuilder: (context, state) {
                      return CustomDialog();
                    }),
                // Change Reminder Type
                GoRoute(
                    name: Routes.changeReminderTypeDialog.name,
                    path: Routes.changeReminderTypeDialog.path,
                    pageBuilder: (context, state) {
                      return CustomDialog();
                    }),
                // Change Reminder Interval
                GoRoute(
                    name: Routes.changeReminderIntervalDialog.name,
                    path: Routes.changeReminderIntervalDialog.path,
                    pageBuilder: (context, state) {
                      return CustomDialog();
                    }),
              ]),
          GoRoute(
              name: Routes.login.name,
              path: Routes.login.path,
              builder: (context, state) => const LoginPage()),
          GoRoute(
              name: Routes.settings.name,
              path: Routes.settings.path,
              builder: (context, state) => const SettingsScreen()),

          /*
          GoRoute(
              name: Routes.settings.name,
              path: Routes.settings.path,
              builder: (context, state) =>
                  SettingsScreen(key: PageKeys.settingsKey)),
          GoRoute(
              name: Routes.profile.name,
              path: Routes.profile.path,
              builder: (context, state) =>
                  ProfileScreen(key: PageKeys.profileKey)),
          GoRoute(
              name: Routes.progress.name,
              path: Routes.progress.path,
              builder: (context, state) =>
                  ProgressScreen(key: PageKeys.progressKey)), */

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

  FutureOr<String?> _rd(BuildContext context, GoRouterState state) {
    final bool loggedIn = BlocProvider.of<AuthenticationBloc>(context).state
        is AuthenticationAuthenticated;
    final bool isLoginScreen =
        state.fullPath == Routes.login.path ? true : false;
    if (!loggedIn && !isLoginScreen) {
      return Routes.login.path;
    }
    if (loggedIn && isLoginScreen) {
      return Routes.menu.path;
    }
    return null;
  }
}
