class Routes {
  static final _menu menu = _menu();
  static final login = _login();
  static final profile = _profile();
  static final settings = _settings();
  static final progress = _progress();
}

class _menu {
  final int index = 0;
  final String name = "menu";
  final String path = "/";
}

class _login {
  final int index = -1;
  final String name = "login";
  final String path = "/login";
}

class _profile {
  final int index = 2;
  final String name = "profile";
  final String path = "/profile";
}

class _settings {
  final int index = 3;
  final String name = "settings";
  final String path = "/settings";
}

class _progress {
  final int index = 1;
  final String name = "progress";
  final String path = "/progress";
}
