import 'package:logger/logger.dart' as log;

abstract class Log {
  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void info(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void append(dynamic message);
  void closeAppend();
}

class Logger implements Log {
  List<String> messages = [];

  final logger = log.Logger();

  @override
  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.d(message, error: error, stackTrace: stackTrace);
  }

  @override
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    logger.w(message, error: error, stackTrace: stackTrace);
  }

  @override
  void append(dynamic message) {
    messages.add(message);
  }

  @override
  void closeAppend() {
    info(messages.join('\n'));
    messages = [];
  }
}
