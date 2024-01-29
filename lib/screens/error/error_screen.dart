import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../custom_styles/routes.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 244, 244, 244)),
            child: Scaffold(
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('An unexpected thing happened!',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600))),
                  ElevatedButton(
                      onPressed: () {
                        // context.go("/");
                        context.goNamed(Routes.menu.name);
                      },
                      child: const Text('Go Back To Menu',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600))),
                ],
              )),
            )));
  }
}
