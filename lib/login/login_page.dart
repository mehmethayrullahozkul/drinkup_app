import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _GetDataPage() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)
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
                        height: 20.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Text(
                        "Drink Up",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ]),
                //const Text(
                //  "Drink Up",
                //  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                //),
                actions: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.list), onPressed: (_GetDataPage))
                ]),
            body: _LoginForm(),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});
  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  //static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static final _k1 = new GlobalKey();
  static final _k2 = new GlobalKey();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _tryLogin() {
    //  _username.clear();
    //  _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
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
              if (constraints.maxHeight >= 600) const SizedBox(height: 40.0),
              SizedBox(
                height: 40.0,
                child: Material(
                  elevation: 5.0,
                  shadowColor: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  child: TextField(
                    key: _k1,
                    //autofocus: true,
                    enableSuggestions: false,
                    // textAlign: TextAlign.center,
                    autocorrect: false,
                    controller: _username,
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
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent))),
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
                    key: _k2,
                    controller: _password,
                    // textAlign: TextAlign.center,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          size: 20.0,
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
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.transparent))),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: constraints.maxHeight >= 500
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.center,
                //spacing: constraints.maxWidth / 5,
                //alignment: WrapAlignment.spaceAround,
                //crossAxisAlignment: WrapCrossAlignment.center,
                direction: (constraints.maxHeight >= 500 ||
                        (constraints.maxWidth <= 600))
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  ElevatedButton(
                    onPressed: _tryLogin,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
      );
    });
  }
}
