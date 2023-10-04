import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../controllers/auth/auth_store.dart';
import '../../erros/erros.dart';
import 'i_client_http.dart';

class ClientHttpImpl implements IClientHttp {
  final Dio dio;
  String? origin;

  ClientHttpImpl(this.dio) {
    dio.options = options;
    origin = 'http://localhost:8080';
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final RequestOptions customOptions = await addAuthHeader(dio, options);

      return handler.next(customOptions);
    }));
  }

  BaseOptions options = BaseOptions(
    baseUrl: "http://192.168.0.79:8080",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  String get token {
    var auth = Modular.get<AuthStore>();
    return auth.user?.token ?? '';
  }

  @override
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      headers = headers ?? {};

      var response = await dio.get(url,
          queryParameters: queryParameters, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      return handleException(e);
    } catch (e) {
      throw Failure();
    }
  }

  @override
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      headers = headers ?? {};

      var response = await dio.post(url,
          data: body,
          queryParameters: queryParameters,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));

      return response;
    } on DioException catch (e) {
      return handleException(e);
    } catch (e) {
      throw Failure();
    }
  }

  @override
  Future<dynamic> getBytes({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      headers = headers ?? {};

      var response = await dio.get<List<int>>(url,
          queryParameters: queryParameters,
          options: Options(headers: headers, responseType: ResponseType.bytes));

      return response;
    } on DioException catch (e) {
      return handleException(e);
    } catch (e) {
      throw Failure();
    }
  }

  @override
  Future put(
      {required String url,
      body,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      headers = headers ?? {};

      var response = await dio.put(url,
          data: body,
          queryParameters: queryParameters,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));

      return response;
    } on DioException catch (e) {
      return handleException(e);
    } catch (e) {
      throw Failure();
    }
  }

  @override
  Future delete(
      {required String url, body, Map<String, dynamic>? headers}) async {
    try {
      headers = headers ?? {};

      var response = await dio.delete(url,
          data: body,
          options:
              Options(headers: headers, contentType: Headers.jsonContentType));

      return response;
    } on DioException catch (e) {
      return handleException(e);
    } catch (e) {
      throw Failure();
    }
  }

  Future<RequestOptions> addAuthHeader(Dio dio, RequestOptions options) async {
    options.headers['Authorization'] = 'Bearer $token';
    return options;
  }

  handleException(dynamic e) {
    if (e is DioException) {
      if (e.response != null) {
        return e.response;
      } else {
        throw Failure(
          message: e.type == DioExceptionType.receiveTimeout
              ? "Tempo limite de solicitação excedido"
              : e.message,
        );
      }
    } else {
      throw Failure();
    }
  }
}
