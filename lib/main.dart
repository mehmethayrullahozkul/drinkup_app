import 'package:flutter/material.dart';
import 'login/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Sofia-Pro'),
      home: const LoginPage(),
    );
  }
}
