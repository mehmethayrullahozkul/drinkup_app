class API {
  static const String baseUrl = "http://10.0.2.2:4000";
  static const String loginUrl = '$baseUrl/api/login';
  static const String authTokenUrl = '$baseUrl/api/authtoken';
  static const String registerUrl = '$baseUrl/api/register';
  static const String logoutUrl = '$baseUrl/api/logout';
  static const String homeUrl = '$baseUrl/api/home';
  static const Duration receiveTimeout = Duration(seconds: 5);
  static const Duration connectTimeout = Duration(seconds: 3);
}
