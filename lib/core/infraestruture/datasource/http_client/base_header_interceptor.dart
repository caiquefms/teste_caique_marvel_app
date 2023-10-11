import 'package:dio/dio.dart';
import '../../local_storage/local_storage.dart';

class BaseHeaderInterceptor extends Interceptor {
  final LocalStorage _localStorage;

  BaseHeaderInterceptor({required LocalStorage localStorage})
      : _localStorage = localStorage;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.queryParameters.addAll({
      'ts': await _localStorage.getInt('ts'),
      'apikey': await _localStorage.getString('apikey'),
      'hash': await _localStorage.getString('hash'),
    });

    handler.next(options);
  }
}
