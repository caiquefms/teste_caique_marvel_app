import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_caique_marvel_app/core/infraestruture/local_storage/secure_local_storage.dart';

import 'secure_local_storage_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late FlutterSecureStorage flutterSecureStorage;
  late SecureLocalStorage localStorage;

  setUp(() {
    flutterSecureStorage = MockFlutterSecureStorage();
    localStorage = SecureLocalStorage(flutterSecureStorage);
  });

  test('Deve buscar uma String', () async {
    when(flutterSecureStorage.read(key: 'title'))
        .thenAnswer((_) async => 'Titulo do App');

    final title = await localStorage.getString('title');

    expect(title, 'Titulo do App');
  });

  test('Deve buscar um Int', () async {
    when(flutterSecureStorage.containsKey(key: 'title'))
        .thenAnswer((_) async => true);
    when(flutterSecureStorage.read(key: 'title')).thenAnswer((_) async => "10");

    final title = await localStorage.getInt('title');

    expect(title, 10);
  });
}
