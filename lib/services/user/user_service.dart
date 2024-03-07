import 'package:drinkup_app/models/user/user_model.dart';
import 'package:drinkup_app/repositories/user/user_repository.dart';
import 'package:drinkup_app/models/credentials/credentials_model.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

class UserService {
  final ValueNotifier<User> _user = ValueNotifier<User>(User());

  User get currentUser => _user.value;

  final UserRepository userRepository = UserRepository();

  UserService._();

  static final UserService _instance = UserService._();

  factory UserService() {
    return _instance;
  }

  Future<void> load() async {
    final bool hasUser = await userRepository.hasLocalUser();

    if (!hasUser) {
      _user.value = User();
      return;
    }

    final User? localUser = await userRepository.loadLocalUser();

    if (localUser == null) {
      _user.value = User();
      return;
    }

    _user.value = localUser;
  }

  Future<void> setUser({required User user}) async {
    _user.value = user;
  }

  Future<void> signOut() async {
    await userRepository.deleteLocalUser();
    _user.value = User();
  }

  Future<void> saveSecureCredentials(
      {required SecureCredentials credentials}) async {
    await userRepository.saveLocalAccessToken(
        access_token: credentials.accesToken);
    await userRepository.saveLocalRefreshToken(
        refresh_token: credentials.refreshToken);
  }

  Future<void> saveUser({required User user}) async {
    if (user is AnonymousUser) {
      await userRepository.saveAnonymousUser(username: user.username);
    } else if (user is AuthenticatedUser) {
      await userRepository.saveAuthenticatedUser(
          username: user.username, mail: user.mail);
    }
  }

  Future<void> saveCurrentUser() async {
    if (currentUser is AnonymousUser) {
      await userRepository.saveAnonymousUser(username: currentUser.username);
    } else if (currentUser is AuthenticatedUser) {
      AuthenticatedUser authenticatedUser = currentUser as AuthenticatedUser;
      await userRepository.saveAuthenticatedUser(
          username: authenticatedUser.username, mail: authenticatedUser.mail);
    }
  }
}
