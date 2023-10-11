import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../local_storage/local_storage.dart';
import '../../../failures/failure.dart';
import '../../log/logger.dart';
import 'base_header_interceptor.dart';
import 'info_interceptor.dart';
import 'failure_handler.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, dynamic>> get({
    required String path,
    Map<String, dynamic> params,
  });
}

class ApiDataSource implements RemoteDataSource {
  final Dio _client;

  ApiDataSource({
    required Dio client,
    required LocalStorage localStorage,
    required Logger logger,
  }) : _client = client {
    _client.interceptors
      ..add(BaseHeaderInterceptor(localStorage: localStorage))
      ..add(InfoInterceptor(logger: logger));

    _client.options = BaseOptions(
      baseUrl: 'https://gateway.marvel.com/v1/public/',
      connectTimeout: Duration(milliseconds: 120000),
      receiveTimeout: Duration(milliseconds: 120000),
    );
  }

  @override
  Future<Either<Failure, dynamic>> get(
      {required String path, fromJson, Map<String, dynamic>? params}) async {
    try {
      final result = await _client.get(path, queryParameters: params);
      return Right(result.data);
    } on DioException catch (dioError) {
      return Left(getFailureFromDioException(dioError));
    }
  }
}
