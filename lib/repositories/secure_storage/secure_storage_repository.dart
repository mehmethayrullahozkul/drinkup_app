import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static const FlutterSecureStorage _secureStorage =
      FlutterSecureStorage();
  static final Storage _instance = Storage._();

  Storage._();

  FlutterSecureStorage get secureStorage => _secureStorage;

  Future<bool> has({required String key}) {
    switch (key) {
      case 'access_token':
        return _secureStorage.containsKey(key: key);
      case 'refresh_token':
        return _secureStorage.containsKey(key: key);
      case 'username':
        return _secureStorage.containsKey(key: key);
      case 'mail':
        return _secureStorage.containsKey(key: key);
      default:
        return _secureStorage.containsKey(key: key);
    }
  }

  Future<void> delete({required String key}) async {
    switch (key) {
      case 'access_token':
        return _secureStorage.delete(key: key);
      case 'refresh_token':
        return _secureStorage.delete(key: key);
      case 'username':
        return _secureStorage.delete(key: key);
      case 'mail':
        return _secureStorage.delete(key: key);
      default:
        return _secureStorage.delete(key: key);
    }
  }

  Future<void> deleteAll() async {
    _secureStorage.deleteAll();
  }

  factory Storage() {
    return _instance;
  }
}
