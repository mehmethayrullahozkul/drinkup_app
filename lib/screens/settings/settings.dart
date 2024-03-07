import 'package:drinkup_app/utils/utils.dart';
import 'package:drinkup_app/screens/schemas/base.dart';
import 'package:flutter/material.dart';
import 'package:drinkup_app/blocs/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static final List<IconData> icons = [
    Icons.invert_colors,
    Icons.notifications_none_rounded,
    Ionicons.water,
    Icons.language_rounded,
    Icons.share_outlined,
    Icons.help_outline_outlined,
    Icons.lightbulb_outline_rounded,
    Icons.logout_rounded,
    Icons.delete_outline_outlined,
  ];

  static final List<String> titles = [
    'Display',
    'Notifications & Sounds',
    'Units',
    'Language',
    'Share DrinkUp',
    'Help & Feedback',
    'About DrinkUp',
    'Logout',
    'Delete Data',
  ];

  static final List<String> subtitles = [
    'Change the AppTheme and font size',
    'Manage notifications and sounds',
    'Change the units of measurement',
    'Change the app language',
    'Share the app with friends',
    'Get help and send feedback',
    'Learn more about the app',
    'Logout from your account',
    'Delete all your data',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        // AppBar
        Container(
          height: 60,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                /* Color.fromARGB(255, 96, 0, 250),
                Color.fromARGB(255, 4, 0, 255), */
                Colors.white,
                Colors.white,
              ],
            ),
            color: const Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              /* BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ), */
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 0),
                    child: SizedBox(
                      height: 30,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          color: Color.fromARGB(255, 41, 41, 41),
                          fontSize: 24,
                          fontFamily: 'Sofia-Pro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  /* const SizedBox(height: 10), */
                ],
              ),
            ),
          ),
        ),
        // Body
        Container(
            margin: EdgeInsets.only(top: 20, left: 16, right: 20, bottom: 20),
            padding: EdgeInsetsDirectional.all(4),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  /*  BoxShadow(
                        color: Color.fromARGB(255, 241, 241, 241),
                        spreadRadius: 10,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ), */
                ]),
            child: Column(children: [
              // Account Box
              Container(
                margin: EdgeInsets.only(top: 20),
                /* padding: EdgeInsetsDirectional.all(10), */
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        /* border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromARGB(255, 124, 124, 124),
                              ),
                            ), */
                      ),
                      child: Text('General',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                            letterSpacing: 0.5,
                            fontFamily: 'Sofia-Pro',
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    ...List<Widget>.generate(icons.length, (index) {
                      return Material(
                        /* color: Colors.transparent, */
                        color: Colors.white,
                        child: InkWell(
                          onTap: (index == 7)
                              ? () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(AuthenticationLogoutButtonPressed());
                                }
                              : () {},
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    child: Icon(
                                      icons[index],
                                      size: 28,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        titles[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 44, 44, 44),
                                          fontFamily: 'Sofia-Pro',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        subtitles[index],
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color.fromARGB(
                                              255, 139, 139, 139),
                                          fontFamily: 'Sofia-Pro',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      );
                    }),
                    /* Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(bottom: 10, top: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        /* border: Border(
                              bottom: BorderSide(
                                width: 0.5,
                                color: Color.fromARGB(255, 124, 124, 124),
                              ),
                            ), */
                      ),
                      child: Text('Personal',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                            letterSpacing: 0.5,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    ...List<Widget>.generate(icons.length, (index) {
                      return Material(
                        /* color: Colors.transparent, */
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    icons[index],
                                    size: 28,
                                    color: const Color.fromARGB(255, 44, 44, 44),
                                  ),
                                  SizedBox(width: 30),
                                  Text(
                                    titles[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 44, 44, 44),
                                      fontFamily: 'Sofia-Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      );
                    }), */
                  ],
                ),
              )
            ])),
      ]),
    );
  }
}
