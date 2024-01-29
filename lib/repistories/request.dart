import 'package:dio/dio.dart';
import 'package:drinkup_app/repistories/api.dart';

class Request {
  static final Dio _dio = Dio();

  Request._() {
    _dio.options.baseUrl = API.baseUrl;
    _dio.options.connectTimeout = API.connectTimeout;
    _dio.options.receiveTimeout = API.receiveTimeout;
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.headers["Accept"] = "application/json";
  }

  static final Request _instance = Request._();

  factory Request() {
    return _instance;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) {
    return _dio.delete(path, data: data);
  }

  Future<Response> patch(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }
}
