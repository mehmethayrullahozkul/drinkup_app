import 'dart:async';
import 'package:drinkup_app/models/user/user_model.dart';
import 'package:drinkup_app/models/credentials/credentials_model.dart';
import 'package:drinkup_app/constants/api/api.dart';
import 'package:drinkup_app/services/request/request_service.dart';
import 'package:dio/dio.dart';
import 'package:drinkup_app/repositories/secure_storage/secure_storage_repository.dart';

class UserRepository {
  Future<bool> hasLocalUser() async {
    final bool hasUsername = await Storage().has(key: 'username');
    final bool hasAnonymous = await Storage().has(key: 'anonymous');
    return hasUsername && hasAnonymous;
  }

  Future<bool> hasLocalAccessToken() async {
    return await Storage().has(key: 'access_token');
  }

  Future<bool> hasLocalRefreshToken() async {
    return await Storage().has(key: 'refresh_token');
  }

  Future<String?> getLocalAccessToken() async {
    return await Storage().secureStorage.read(key: 'access_token');
  }

  Future<String?> getLocalUsername() async {
    return await Storage().secureStorage.read(key: 'username');
  }

  Future<String?> getLocalRefreshToken() async {
    return await Storage().secureStorage.read(key: 'refresh_token');
  }

  Future<void> saveLocalAccessToken({required String access_token}) async {
    await Storage()
        .secureStorage
        .write(key: 'access_token', value: access_token);
  }

  Future<void> saveLocalRefreshToken({required String refresh_token}) async {
    await Storage()
        .secureStorage
        .write(key: 'refresh_token', value: refresh_token);
  }

  Future<void> deleteLocalAccessToken() async {
    await Storage().delete(key: 'access_token');
  }

  Future<void> deleteLocalRefreshToken() async {
    await Storage().delete(key: 'refresh_token');
  }

  Future<void> deleteLocalUser() async {
    await Storage().deleteAll();
  }

  Future<User?> loadLocalUser() async {
    final bool hasUser = await hasLocalUser();
    if (!hasUser) return null;
    final bool isAnonymous =
        await Storage().secureStorage.read(key: 'anonymous') == "true";
    final String? username =
        await Storage().secureStorage.read(key: 'username');
    if (isAnonymous) {
      return AnonymousUser(username: username!);
    } else {
      final String? mail = await Storage().secureStorage.read(key: 'mail');
      return AuthenticatedUser(username: username!, mail: mail!);
    }
  }

  Future<User> signIn(
      {required SignInCredentials credentials,
      required bool isAnonymus}) async {
    if (isAnonymus) {
      return AnonymousUser(username: credentials.username);
    } else {
      try {
        final Response response = await _request.post(
          API.signInUrl,
          data: credentials.toJson(),
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = response.data;
          if (data['access_token'] == null || data['username'] == null) {
            return User();
          }
          if (data['username'] != credentials.username) return User();
          return SecureUser(
              credentials: SecureCredentials(
                  refresh_token: data['refresh_token'],
                  access_token: data['access_token']),
              mail: data['mail'],
              username: data['username']);
        } else {
          return User();
        }
      } catch (e) {
        return User();
      }
    }
  }

  Future<bool> validateAccessToken(
      {required String username, required String token}) async {
    try {
      final Response response = await _request.post(
        API.authTokenUrl,
        data: {"token": token, "username": username},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        if (data['validation'] == null) {
          return false;
        }
        if (data['validation'] == 'true') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> saveAnonymousUser({required String username}) async {
    await Storage().secureStorage.deleteAll();
    await Storage().secureStorage.write(key: 'username', value: username);
    await Storage().secureStorage.write(key: 'anonymous', value: "true");
  }

  Future<void> saveAuthenticatedUser(
      {required String username, required String mail}) async {
    await Storage().secureStorage.deleteAll();
    await Storage().secureStorage.write(key: 'username', value: username);
    await Storage().secureStorage.write(key: 'mail', value: mail);
    await Storage().secureStorage.write(key: 'anonymous', value: "false");
  }

  final RequestService _request = RequestService();
  final _authStatusController = StreamController<bool>();
  Stream<bool> get authStatusStream => _authStatusController.stream;

  Future<void> saveAccessToken(String token) async {
    await Storage().secureStorage.write(key: 'access_token', value: token);
  }

  Future<bool> hasAccessToken() async {
    return Storage().has(key: 'access_token');
  }

  Future<bool> auth() async {
    late final Response response;
    final token = await Storage().secureStorage.read(key: 'access_token');
    //final token = await _storage.read(key: 'token');
    try {
      response = await _request.post(API.authTokenUrl, data: {"token": token});
      if (response.statusCode == 200) {
        _authStatusController.add(
            true); // Notify subscribers about the authentication status change
        return true;
      } else {
        _authStatusController.add(
            false); // Notify subscribers about the authentication status change
        return false;
      }
    } on DioException {
      _authStatusController.add(
          false); // Notify subscribers about the authentication status change
      return false;
    }
  }

  void dispose() {
    _authStatusController.close();
  }
}
