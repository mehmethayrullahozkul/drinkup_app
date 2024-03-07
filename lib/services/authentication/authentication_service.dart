import 'package:drinkup_app/models/user/user_model.dart';
import 'package:drinkup_app/repositories/user/user_repository.dart';
import 'package:drinkup_app/models/credentials/credentials_model.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

class AuthenticationService {
  final ValueNotifier<bool> auth = ValueNotifier<bool>(false);

  final UserRepository userRepository = UserRepository();

  AuthenticationService._();

  static final AuthenticationService _instance = AuthenticationService._();

  factory AuthenticationService() {
    return _instance;
  }

  Future<void> load() async {
    final bool hasUser = await userRepository.hasLocalUser();

    if (!hasUser) {
      auth.value = (false);
      return;
    }

    final User? user = await userRepository.loadLocalUser();

    if (user == null) {
      auth.value = (false);
      return;
    }

    if (user is AnonymousUser) {
      auth.value = (true);
      return;
    } else if (user is AuthenticatedUser) {
      final bool hasToken = await userRepository.hasLocalAccessToken();
      if (!hasToken) {
        auth.value = (false);
        return;
      }
      final String? token = await userRepository.getLocalAccessToken();
      if (token == null) {
        auth.value = (false);
        return;
      }
      final bool isTokenValid = await userRepository.validateAccessToken(
          token: token, username: user.username);
      if (!isTokenValid) {
        auth.value = (false);
        return;
      }
    }
  }

  Future<User> signIn(
      {required String username,
      required String password,
      required bool anonymous}) async {
    print("current auth value: ${auth.value}");
    // sanitize here
    final User user = await userRepository.signIn(
        credentials: SignInCredentials(username: username, password: password),
        isAnonymus: anonymous);
    if (user is AnonymousUser || user is SecureUser) {
      print('User is Anonymous or Secure');
      auth.value = (true);
    } else {
      print('User is not Anonymous or Secure');
      auth.value = false;
    }
    return user;
  }

  Future<void> signOut() async {
    auth.value = (false);
  }
}
