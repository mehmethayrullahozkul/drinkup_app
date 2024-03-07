import 'package:drinkup_app/models/credentials/credentials_model.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String _username;
  final bool _isAnonymous;
  final bool _isValid;

  String get username => _username;
  bool get anonymous => _isAnonymous;
  bool get valid => _isValid;

  const User._(this._username, this._isAnonymous, this._isValid);

  factory User({String username = '', bool isAnonymous = true}) {
    return User._(username, isAnonymous, false);
  }

  @override
  List<Object> get props => [_username, _isAnonymous, _isValid];
}

class AnonymousUser extends User {
  const AnonymousUser({required String username})
      : super._(username, true, true);

  @override
  String toString() {
    return 'AnonymousUser{username: $_username}';
  }
}

class AuthenticatedUser extends User {
  final String mail;
  const AuthenticatedUser({required String username, required this.mail})
      : super._(username, false, true);

  String get displayMail => mail;

  @override
  String toString() {
    return 'AuthenticatedUser{username: $_username}';
  }
}

class SecureUser extends User {
  final SecureCredentials _credentials;
  final String _mail;

  String get mail => _mail;
  SecureCredentials get credentials => _credentials;

  const SecureUser(
      {required String username,
      required String mail,
      required SecureCredentials credentials})
      : _mail = mail,
        _credentials = credentials,
        super._(username, false, true);

  @override
  List<Object> get props => [_username, _isAnonymous, _isValid, _mail];
}
