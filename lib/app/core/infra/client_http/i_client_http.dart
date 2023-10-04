abstract class IClientHttp {
  static String get clientId => '4efdb70e';

  Future<dynamic> get(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic> headers = const {}});

  Future<dynamic> post(
      {required String url,
      Map<String, dynamic>? queryParameters,
      dynamic body,
      Map<String, dynamic> headers = const {}});

  Future<dynamic> put(
      {required String url,
        Map<String, dynamic>? queryParameters,
      dynamic body,
      Map<String, dynamic> headers = const {}});

  Future<dynamic> delete(
      {required String url,
      dynamic body,
      Map<String, dynamic> headers = const {}});

  Future<dynamic> getBytes(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic> headers = const {}});
}
