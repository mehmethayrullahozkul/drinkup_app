import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/blocs/auth/auth.dart';
import 'package:drinkup_app/blocs/login/login_bloc.dart';
import 'package:drinkup_app/repistories/user.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'dart:convert';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 244, 244, 244)
                      //  gradient: LinearGradient(
                      //      begin: Alignment.topLeft,
                      //      end: Alignment.bottomRight,
                      //      stops: [0.1, 0.4, 0.6, 0.9],
                      //      colors: [
                      //        //Color(0xff1f005c),
                      //        //Color(0xff5b0060),
                      //        //Color(0xff870160),
                      //        //Color(0xffac255e),
                      //        //Color(0xffca485c),
                      //        //Color(0xffe16b5c),
                      //        //Color(0xfff39060),
                      //        //Color(0xffffb56b),
                      //      ],
                      //      tileMode: TileMode.mirror),
                      ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  toolbarHeight: 70.0,
                  backgroundColor: Colors.transparent,
                  foregroundColor: const Color.fromARGB(255, 0, 156, 217),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      //textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/water_droplet_logo.png',
                          fit: BoxFit.cover,
                          height: 30.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          "Drink Up",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w900),
                        ),
                      ]),
                  //const Text(
                  //  "Drink Up",
                  //  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  //),
                  /*actions: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.list), onPressed: (_GetDataPage))
                ]*/
                ),
                body: LoginForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
