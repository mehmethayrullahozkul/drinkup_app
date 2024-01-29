import 'package:go_router/go_router.dart';
import 'package:drinkup_app/blocs/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/screens/custom_styles/main_schema.dart';
import 'package:drinkup_app/screens/custom_styles/routes.dart';
import 'package:drinkup_app/screens/custom_styles/rp_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
      child: Flex(
          direction: Axis.vertical,
          children: [Center(child: Text("Main Screen"))]),
    );
  }
}
