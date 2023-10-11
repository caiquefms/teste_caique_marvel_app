import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../log/logger.dart';

class InfoInterceptor extends Interceptor {
  final Logger _logger;

  InfoInterceptor({
    required Logger logger,
  }) : _logger = logger;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!kReleaseMode) {
      _logger.append('######### Request LOG  #########');
      _logger.append('url: ${options.uri}');
      _logger.append('method: ${options.method}');
      _logger.append('data: ${options.data}');
      _logger.append('headers: ${options.headers}');
      _logger.append('######### Request LOG  #########');
      _logger.closeAppend();
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kReleaseMode) {
      _logger.append('######### Response LOG  #########');
      _logger.append('Response statusCode: ${response.statusCode}');
      _logger.append('data: ${response.data}');
      _logger.append('######### Response LOG  #########');
      _logger.closeAppend();
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!kReleaseMode) {
      _logger.append('######### Error LOG  #########');
      _logger.append('Response statusCode: ${err.response?.statusCode}');
      _logger.append('Response error: ${err.response}');
      _logger.append('######### Error LOG  #########');
      _logger.closeAppend();
    }

    handler.next(err);
  }
}
