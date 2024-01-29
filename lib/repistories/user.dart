import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:drinkup_app/repistories/api.dart';
import 'package:drinkup_app/repistories/request.dart';
import 'package:dio/dio.dart';
import 'package:drinkup_app/repistories/storage.dart';

class UserRepository extends Equatable {
  late final String _username;
  late final String _mail;

  static final Request _request = Request();

  final _authStatusController = StreamController<bool>();

  UserRepository._() {}

  static final UserRepository _instance = UserRepository._();

  factory UserRepository() {
    return _instance;
  }

  Stream<bool> get authStatusStream => _authStatusController.stream;

//  Future<String>  => await _storage.read(key: 'token');

  /* Future<bool> hasUser() async {} */

  Future<void> saveAccessToken(String token) async {
    await Storage().secureStorage.write(key: 'access_token', value: token);
  }

  Future<bool> hasAccessToken() async {
    return Storage().has(key: 'access_token');
  }

  Future<String> login(String username, String password) async {
    Response response = await _request.post(API.loginUrl, data: {
      "email": username,
      "password": password,
    });
    final token = response.data["token"];
    _authStatusController
        .add(true); // Notify subscribers about the authentication status change
    return token;
  }

  Future<void> logout() async {
    await Storage().delete(key: 'access_token');
    //_authStatusController.add(
    //  false); // Notify subscribers about the authentication status change
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
    } on DioException catch (e) {
      _authStatusController.add(
          false); // Notify subscribers about the authentication status change
      return false;
    }
  }

  void dispose() {
    _authStatusController.close();
  }

  @override
  List<Object> get props => [_username];
}

//class AnonymusUserRepository extends UserRepository {}
