import 'package:dio/dio.dart';
import '../../../failures/http_failures.dart';

HttpFailure getFailureFromDioException(DioException exception) {
  switch (exception.response?.statusCode) {
    case 400:
      return BadRequestFailure(
        message: exception.message?.isNotEmpty ?? false
            ? exception.message!
            : 'Falha na requisição. Request inválido.',
      );
    case 401:
      return UnauthorizedFailure(
        message: exception.message?.isNotEmpty ?? false
            ? exception.message!
            : 'Falha na requisição. Sem autorização.',
      );
    case 403:
      return ForbbidenFailure(
        message: exception.message?.isNotEmpty ?? false
            ? exception.message!
            : 'Falha na requisição. Acesso negado.',
      );
    case 405:
      return MethodNotAllowedFailure(
        message: exception.message?.isNotEmpty ?? false
            ? exception.message!
            : 'Falha na requisição.O verbo HTTP utilizado não é suportado.',
      );
    case 409:
      return ConflictFailure(
        message: exception.message?.isNotEmpty ?? false
            ? exception.message!
            : 'Falha na requisição. Houve um conflito com um recurso que está no servidor.',
      );
    default:
      return ServerFailure(
        message: exception.message?.isNotEmpty ?? false
            ? exception.message!
            : 'Falha na requisição. Dificuldade no processamento do servidor,',
      );
  }
}
