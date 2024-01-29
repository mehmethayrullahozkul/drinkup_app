import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();
  static late final SharedPreferences _localStorage;
  static Storage? _instance;

  Storage._();

  static Future<Storage> initStorage() async {
    if (_instance == null) {
      _instance = Storage._();
      _localStorage = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  FlutterSecureStorage get secureStorage => _secureStorage;
  SharedPreferences get localStorage => _localStorage;

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
      case 'data':
        return Future.value(_localStorage.containsKey(key));
      case 'user':
        return Future.value(_localStorage.containsKey(key));
      default:
        return Future.value(_localStorage.containsKey(key));
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
      case 'data':
        await _localStorage.remove(key);
        return;
      default:
        await _localStorage.remove(key);
        return;
    }
  }

  Future<void> deleteAll() async {
    _secureStorage.deleteAll();
    _localStorage.clear();
  }

  factory Storage() {
    return _instance!;
  }
}
