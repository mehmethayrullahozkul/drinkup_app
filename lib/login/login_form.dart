import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/blocs/auth/auth.dart';
import 'package:drinkup_app/blocs/login/login_bloc.dart';
import 'package:drinkup_app/blocs/network/network.dart';
import 'package:drinkup_app/blocs/network/network_bloc.dart';
import 'dart:async';
import 'package:drinkup_app/repistories/user.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:drinkup_app/screens/custom_styles/routes.dart';

class LoginForm extends StatefulWidget {
  late final UserRepository userRepository;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final UserRepository userRepistory;

  @override
  void initState() {
    super.initState();
    userRepistory = RepositoryProvider.of<UserRepository>(context);
  }

  //static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  GlobalKey<FormState> _k1 = GlobalKey<FormState>();
  GlobalKey<FormState> _k2 = GlobalKey<FormState>();
  //static final _k1 = GlobalKey();
  //static final _k2 = GlobalKey();

  final TextEditingController _usernameField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  bool _password_visible = false;
  final bool _is_loading = false;
  final String _message = "INITIAL";
  final bool _is_message_visible = true;

  //final String _loginUrl = 'ws://localhost:3000/login';
  //final String _protectedUrl = 'ws://localhost:3000/protected';

  //void _tryLogin() {
  //  //final String loginUrl = 'ws://37.247.108.184:3000/login';
  //  //final String protectedUrl = 'ws://37.247.108.184:3000/protected';
  //  final String _username = "hayrureis";
  //  final String _password = "cokbuyuk";
  //  if (_usernameField.text.isEmpty) {
  //    setState(() {
  //      _message = "Username can not be empty.";
  //    });
  //    return;
  //  } else if (_passwordField.text.isEmpty) {
  //    setState(() {
  //      _message = "Password can not be empty.";
  //    });
  //    return;
  //  }
  //  print("Trying Login...");
  //  WebSocketChannel _channel;
  //  //_TryConnect();
  //  //_Connect(_username, _password);
//
  //  _channel = IOWebSocketChannel.connect(_loginUrl);
//
  //  _channel.stream.listen((message) {
  //    final data = json.decode(message);
  //    final token = data['token'];
//
  //    print("Trying Login...");
  //    print('Token: $token');
  //    setState(() {
  //      _message = data;
  //    });
//
  //    // Store the token securely for future use
  //    // ...
  //    _channel.sink.close();
  //  });
//
  //  final request = {'username': _username, 'password': _password};
  //  _channel.sink.add(json.encode(request));
  //}
//
  //void _Connect(final String username, final String password) {
  //  _TryServer();
  //}
//
  //Future<void> _TryServer() async {
  //  setState(() {
  //    _message = "Sorry, couldn't connect to the server.";
  //    _is_message_visible = true;
  //  });
  //  return Future.delayed(Duration(seconds: 4), () {
  //    setState(() {
  //      _message = "Has returned!";
  //      _is_message_visible = false;
  //    });
  //  });
  //}
//
  //Future<void> _TryConnect() async {
  //  setState(() {
  //    _is_loading = true;
  //  });
  //  return Future.delayed(Duration(seconds: 4), () {
  //    _is_loading = false;
  //  });
  //}

  void _ChangePasswordVisibility() {
    setState(() {
      _password_visible = _password_visible ? false : true;
    });
  }

  @override
  void dispose() {
    _passwordField.dispose();
    _usernameField.dispose();
    super.dispose();
  }

  /*
   *
   * build method start
   * display begins
   * 
  */

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() async {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          username: _usernameField.text, password: _passwordField.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Login Failed"), backgroundColor: Colors.red));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          return Stack(children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
              //width: MediaQuery.of(context).size.width / 1.2,

              // CAN NOT USE EXPANDED INSIDE SINGLE_CHILD_SCROLL_VIEW
              child: SingleChildScrollView(
                child: Column(
                  //physics: const AlwaysScrollableScrollPhysics(),
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: constraints.maxHeight >= 500
                          ? constraints.maxHeight / 4
                          : constraints.maxHeight / 5,
                    ),
                    const SizedBox(
                        height: 40.0,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 40.0,
                              letterSpacing: 0.5),
                        )),
                    const SizedBox(height: 9.0),
                    const SizedBox(
                      height: 30.0,
                      child: Text(
                        "Please sign in to continue",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                            letterSpacing: 0.1,
                            color: Colors.grey),
                      ),
                    ),
                    if (constraints.maxHeight >= 600)
                      const SizedBox(height: 20.0),
                    SizedBox(
                      height: 15.0,
                      child: AnimatedOpacity(
                        opacity: _is_message_visible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: BlocBuilder<NetworkBloc, NetworkState>(
                          bloc: BlocProvider.of<NetworkBloc>(context),
                          builder: (context, state) {
                            switch (state.isConnected) {
                              case true:
                                return Text("CONNECTED");
                              case false:
                                return Text("DISCONNECTED");
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      child: Material(
                        elevation: 5.0,
                        shadowColor: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextField(
                          key: _k1,
                          style: const TextStyle(fontSize: 13.0),
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _usernameField,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.mail_outlined,
                                size: 20.0,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  fontSize: 13.0,
                                  color: Color.fromARGB(255, 139, 139, 139)),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 40.0,
                      child: Material(
                        elevation: 5.0,
                        shadowColor: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextField(
                          style: const TextStyle(fontSize: 13.0),
                          key: _k2,
                          controller: _passwordField,
                          obscureText: _password_visible ? false : true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock_open_outlined,
                                size: 20.0,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _password_visible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 20.0,
                                  color:
                                      const Color.fromARGB(255, 145, 145, 145),
                                ),
                                onPressed: () {
                                  _ChangePasswordVisibility();
                                },
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                  fontSize: 13.0,
                                  color: Color.fromARGB(255, 139, 139, 139)),
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 0.0, 20.0, 0.0),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Flex(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: constraints.maxHeight >= 500
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.center,
                      direction: (constraints.maxHeight >= 500 ||
                              (constraints.maxWidth <= 600))
                          ? Axis.vertical
                          : Axis.horizontal,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _onLoginButtonPressed();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return const Color.fromARGB(255, 59, 59, 59);
                                }
                                return null; // Use the component's default.
                              },
                            ),
                            foregroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    Colors.white),
                            padding: const MaterialStatePropertyAll<
                                    EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0)),
                          ),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                            height: (constraints.maxHeight >= 500)
                                ? constraints.maxHeight / 4
                                : 50.0),
                        Container(
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            runSpacing: 10.0,
                            children: [
                              const Text(
                                "Don't have an account yet? ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 150, 150, 150)),
                              ),
                              InkWell(
                                child: const Text(
                                  "Create Now!",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 124, 207)),
                                ),
                                onTap: () {
                                  //
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_is_loading)
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    color: const Color.fromARGB(159, 208, 208, 208),
                    child: const Center(
                      child: SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballRotateChase,
                          strokeWidth: 100.0,
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                            Colors.indigo,
                            Colors.purple,
                          ],
                        ),
                      ),
                    )),
              )
          ]);
        });
      }),
    );
  }
}

/*

LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
          //width: MediaQuery.of(context).size.width / 1.2,

          // CAN NOT USE EXPANDED INSIDE SINGLE_CHILD_SCROLL_VIEW
          child: SingleChildScrollView(
            child: Column(
              //physics: const AlwaysScrollableScrollPhysics(),
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: constraints.maxHeight >= 500
                      ? constraints.maxHeight / 4
                      : constraints.maxHeight / 5,
                ),
                const SizedBox(
                    height: 40.0,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 40.0,
                          letterSpacing: 0.5),
                    )),
                const SizedBox(height: 9.0),
                const SizedBox(
                  height: 30.0,
                  child: Text(
                    "Please sign in to continue",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        letterSpacing: 0.1,
                        color: Colors.grey),
                  ),
                ),
                if (constraints.maxHeight >= 600) const SizedBox(height: 20.0),
                SizedBox(
                  height: 15.0,
                  child: AnimatedOpacity(
                    opacity: _is_message_visible ? 1.0 : 0.0,
                    child: Text(_message),
                    duration: Duration(milliseconds: 500),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  child: Material(
                    elevation: 5.0,
                    shadowColor: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      key: _k1,
                      style: TextStyle(fontSize: 13.0),
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _usernameField,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail_outlined,
                            size: 20.0,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Username',
                          hintStyle: TextStyle(
                              fontSize: 13.0,
                              color: Color.fromARGB(255, 139, 139, 139)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  height: 40.0,
                  child: Material(
                    elevation: 5.0,
                    shadowColor: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      style: TextStyle(fontSize: 13.0),
                      key: _k2,
                      controller: _passwordField,
                      obscureText: _password_visible ? false : true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_open_outlined,
                            size: 20.0,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _password_visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 20.0,
                              color: Color.fromARGB(255, 145, 145, 145),
                            ),
                            onPressed: () {
                              _ChangePasswordVisibility();
                            },
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              fontSize: 13.0,
                              color: Color.fromARGB(255, 139, 139, 139)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: constraints.maxHeight >= 500
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.center,
                  direction: (constraints.maxHeight >= 500 ||
                          (constraints.maxWidth <= 600))
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //_tryLogin();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color.fromARGB(255, 59, 59, 59);
                            }
                            return null; // Use the component's default.
                          },
                        ),
                        foregroundColor:
                            const MaterialStatePropertyAll<Color>(Colors.white),
                        padding:
                            const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 25.0)),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                        height: (constraints.maxHeight >= 500)
                            ? constraints.maxHeight / 4
                            : 50.0),
                    Container(
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        runSpacing: 10.0,
                        children: [
                          Text(
                            "Don't have an account yet? ",
                            style: TextStyle(
                                color: Color.fromARGB(255, 150, 150, 150)),
                          ),
                          InkWell(
                            child: Text(
                              "Create Now!",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 124, 207)),
                            ),
                            onTap: () {
                              print("Ima go crazy");
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_is_loading)
          AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 200),
            child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Color.fromARGB(159, 208, 208, 208),
                child: Center(
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballRotateChase,
                      strokeWidth: 100.0,
                      colors: [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.indigo,
                        Colors.purple,
                      ],
                    ),
                  ),
                )),
          )
      ]);
    });

*/
