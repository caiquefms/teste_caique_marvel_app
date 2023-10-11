import 'failure.dart';

abstract class HttpFailure extends Failure {
  final int statusCode;

  HttpFailure(
      {required this.statusCode, required String message, String? cause})
      : super(message: message, cause: cause);
}

class BadRequestFailure extends HttpFailure {
  BadRequestFailure({required String message})
      : super(statusCode: 400, message: message, cause: null);
}

class UnauthorizedFailure extends HttpFailure {
  UnauthorizedFailure({required String message})
      : super(statusCode: 401, message: message, cause: null);
}

class ForbbidenFailure extends HttpFailure {
  ForbbidenFailure({required String message})
      : super(statusCode: 403, message: message, cause: null);
}

class MethodNotAllowedFailure extends HttpFailure {
  MethodNotAllowedFailure({required String message})
      : super(statusCode: 405, message: message, cause: null);
}

class ConflictFailure extends HttpFailure {
  ConflictFailure({required String message})
      : super(statusCode: 409, message: message, cause: null);
}

class ServerFailure extends HttpFailure {
  ServerFailure({required String message})
      : super(statusCode: 500, message: message, cause: null);
}
