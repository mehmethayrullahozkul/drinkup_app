// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/repistories/router.dart';
import 'package:drinkup_app/screens/custom_styles/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/blocs/auth/auth.dart';
import 'package:drinkup_app/screens/menu/main_menu.dart';
import 'package:drinkup_app/screens/profile/profile.dart';
import 'package:drinkup_app/screens/progress/progress.dart';
import 'package:drinkup_app/screens/settings/settings.dart';

/// A widget that makes it easy to create a screen with a square-ish
/// main area, a smaller menu area, and a small area for a message on top.
/// It works in both orientations on mobile- and tablet-sized screens.
class MainSchema extends StatefulWidget {
  @override
  State<MainSchema> createState() => _MainSchemaState();
}

class _MainSchemaState extends State<MainSchema> {
  //final Widget rectangularMainArea;
  /* int currentPageIndex = AppRouter.index; */
  int currentPageIndex = Routes.menu.index;

  //final Widget child;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // This widget wants to fill the whole screen.
        final size = constraints.biggest;
        final padding = EdgeInsets.all(size.shortestSide / 40);

        if (size.height >= size.width) {
          // "Portrait" / "mobile" mode.
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 15, 94, 156),
                    Color.fromARGB(255, 35, 137, 218),
                    Color.fromARGB(255, 28, 163, 236),
                    Color.fromARGB(255, 90, 188, 216),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  toolbarHeight: 80.0,
                  centerTitle:
                      false, // Set to false to allow custom positioning
                  titleSpacing: 0.0,
                  backgroundColor: Colors.transparent,
                  title: Transform(
                    transform: Matrix4.translationValues(20.0, 10.0, 0.0),
                    child: const Text(
                      "Drink Up",
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          LoggedOut(),
                        );
                      },
                      icon: Icon(Icons.logout, color: Colors.white),
                    )
                  ],
                ),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border(
                          top: BorderSide(
                              color: Color.fromARGB(255, 117, 117, 117),
                              width: 0.1))),
                  child: NavigationBar(
                    height: 80.0,
                    selectedIndex: currentPageIndex,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    elevation: 10.0,
                    indicatorColor: Color.fromARGB(0, 112, 157, 165),
                    indicatorShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    shadowColor: Color.fromARGB(40, 189, 189, 189),
                    animationDuration: Duration(milliseconds: 100),
                    overlayColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(249, 238, 238, 238)),
                    labelBehavior:
                        NavigationDestinationLabelBehavior.alwaysShow,
                    destinations: [
                      NavigationDestination(
                        selectedIcon: Icon(
                          Icons.home,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(
                          Icons.archive,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        icon: Icon(Icons.archive),
                        label: 'Progress',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                      NavigationDestination(
                        selectedIcon: Icon(
                          Icons.settings,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                      ),
                    ],
                    onDestinationSelected: (index) {
                      print("destination select called");
                      if (index == Routes.menu.index) {
                        currentPageIndex = Routes.menu.index;
                        setState(() {});
                        /* context.goNamed(Routes.menu.name); */
                      } else if (index == Routes.progress.index) {
                        currentPageIndex = Routes.progress.index;
                        setState(() {});
                        /* context.goNamed(Routes.progress.name); */
                      } else if (index == Routes.profile.index) {
                        currentPageIndex = Routes.profile.index;
                        setState(() {});

                        /* context.goNamed(Routes.profile.name); */
                      } else if (index == Routes.settings.index) {
                        currentPageIndex = Routes.settings.index;
                        setState(() {});
                        /* context.goNamed(Routes.settings.name); */
                      } else {
                        currentPageIndex = Routes.menu.index;
                        setState(() {});
                        /* context.goNamed(Routes.menu.name); */
                      }
                    },
                  ),
                ),
                body: DefaultTextStyle(
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                    child: getPage(currentPageIndex)),
                /* crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: padding,
                      child: topMessageArea,
                    ),
                  ),
                  Expanded(
                    flex: (mainAreaProminence * 100).round(),
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      minimum: padding,
                      child: squarishMainArea,
                    ),
                  ),
                  SafeArea(
                    top: false,
                    maintainBottomViewPadding: true,
                    child: Padding(
                      padding: padding,
                      child: rectangularMenuArea,
                    ),
                  ),
                ], */
              ),
            ),
          );
        } else {
          // "Landscape" / "tablet" mode.
          final isLarge = size.width > 900;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: isLarge ? 7 : 5,
                child: SafeArea(
                  right: false,
                  maintainBottomViewPadding: true,
                  minimum: padding,
                  child: Text(""),
                ),
              ),
              /* Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      left: false,
                      maintainBottomViewPadding: true,
                      child: Padding(
                        padding: padding,
                        child: topMessageArea,
                      ),
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false,
                        left: false,
                        maintainBottomViewPadding: true,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: padding,
                            child: rectangularMenuArea,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ), */
            ],
          );
        }
      },
    );
  }
}

Widget getPage(int index) {
  if (index == Routes.menu.index) {
    return MainScreen();
  } else if (index == Routes.progress.index) {
    return ProgressScreen();
  } else if (index == Routes.profile.index) {
    return ProfileScreen();
  } else if (index == Routes.settings.index) {
    return SettingsScreen();
  }
  return MainScreen();
}
