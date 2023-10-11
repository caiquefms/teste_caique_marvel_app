import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_caique_marvel_app/core/infraestruture/log/logger.dart'
    as LoggerImpl;

import 'log_test.mocks.dart';

@GenerateMocks([Logger])
void main() {
  late Logger logger;
  late LoggerImpl.Logger loggerImpl;

  setUp(() {
    logger = MockLogger();
    loggerImpl = LoggerImpl.Logger(logger);
  });

  test('Deve realizar um debug', () async {
    when(logger.d("")).thenReturn(() {});
    loggerImpl.debug("");
    verify(logger.d("")).called(1);
  });

  test('Deve realizar um info', () async {
    when(logger.i("")).thenReturn(() {});
    loggerImpl.info("");
    verify(logger.i("")).called(1);
  });

  test('Deve realizar um warning', () async {
    when(logger.w("")).thenReturn(() {});
    loggerImpl.warning("");
    verify(logger.w("")).called(1);
  });

  test('Deve realizar um error', () async {
    when(logger.e("")).thenReturn(() {});
    loggerImpl.error("");
    verify(logger.e("")).called(1);
  });

  test('Deve realizar um append', () async {
    loggerImpl.append("abc");
    loggerImpl.append("cba");
    expect(loggerImpl.messages.length, 2);
  });

  test('Deve realizar um closeAppend', () async {
    when(logger.i('abc\ncba')).thenReturn(() {});
    loggerImpl.append("abc");
    loggerImpl.append("cba");
    loggerImpl.closeAppend();
    expect(loggerImpl.messages.length, 0);
    verify(logger.i('abc\ncba')).called(1);
  });
}
