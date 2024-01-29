import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/screens/custom_styles/main_schema.dart';
import '../custom_styles/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Settings Screen"),
      ),
    );
  }
}
