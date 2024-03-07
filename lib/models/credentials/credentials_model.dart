abstract class Credentials {
  const Credentials();
}

class SignInCredentials extends Credentials {
  final String _username;
  final String _password;

  SignInCredentials({
    required String username,
    required String password,
  })  : _password = password,
        _username = username;

  Map<String, dynamic> toJson() {
    return {
      'username': _username,
      'password': _password,
    };
  }

  factory SignInCredentials.fromJson(Map<String, dynamic> json) {
    return SignInCredentials(
      username: json['username'],
      password: json['password'],
    );
  }

  String get password => _password;
  String get username => _username;
}

class RegisterCredentials extends Credentials {
  final String _username;
  final String _mail;
  final String _password;

  RegisterCredentials({
    required String username,
    required String mail,
    required String password,
  })  : _mail = mail,
        _password = password,
        _username = username;

  Map<String, dynamic> toJson() {
    return {
      'username': _username,
      'mail': _mail,
      'password': _password,
    };
  }

  factory RegisterCredentials.fromJson(Map<String, dynamic> json) {
    return RegisterCredentials(
      username: json['username'],
      mail: json['mail'],
      password: json['password'],
    );
  }

  String get mail => _mail;
  String get password => _password;
  String get username => _username;
}

class ResetPasswordCredentials extends Credentials {
  final String _mail;

  ResetPasswordCredentials({required String mail}) : _mail = mail;

  Map<String, dynamic> toJson() {
    return {
      'mail': _mail,
    };
  }

  factory ResetPasswordCredentials.fromJson(Map<String, dynamic> json) {
    return ResetPasswordCredentials(mail: json['mail']);
  }

  String get mail => _mail;
}

class SecureCredentials extends Credentials {
  final String _refreshToken;
  final String _accessToken;

  SecureCredentials({
    required String refresh_token,
    required String access_token,
  })  : _accessToken = access_token,
        _refreshToken = refresh_token;

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': _refreshToken,
      'access_token': _accessToken,
    };
  }

  factory SecureCredentials.fromJson(Map<String, dynamic> json) {
    return SecureCredentials(
      refresh_token: json['refresh_token'],
      access_token: json['access_token'],
    );
  }

  String get accesToken => _accessToken;
  String get refreshToken => _refreshToken;
}
