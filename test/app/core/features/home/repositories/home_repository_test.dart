import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_caique_marvel_app/core/failures/http_failures.dart';
import 'package:teste_caique_marvel_app/core/infraestruture/datasource/http_client/api_datasource.dart';
import 'package:teste_caique_marvel_app/features/home/models/character_data_wrapper.dart';
import 'package:teste_caique_marvel_app/features/home/repositories/home_repository.dart';
import '../data_mocks.dart';

import 'home_repository_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late RemoteDataSource remoteDataSource;
  late HomeRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    repositoryImpl = HomeRepositoryImpl(remoteDataSource: remoteDataSource);
  });

  test('Deve retornar um Right de CharacterDataWrapper', () async {
    when(remoteDataSource.get(path: "characters", params: {
      'limit': 10,
      'offset': 0,
    })).thenAnswer((_) async => Right(json_characters));

    final result = await repositoryImpl.getCharacters(limit: 10, offset: 0);

    expect(result, isA<Right>());
    expect(result.fold(id, id), isA<CharacterDataWrapper>());

    verify(remoteDataSource.get(path: "characters", params: {
      'limit': 10,
      'offset': 0,
    })).called(1);
    verifyNoMoreInteractions(remoteDataSource);
  });

  test('Deve retornar um Left de Failure', () async {
    when(remoteDataSource.get(path: "characters", params: {
      'limit': 10,
      'offset': 0,
    })).thenAnswer((_) async => Left(BadRequestFailure(message: "")));

    final result = await repositoryImpl.getCharacters(limit: 10, offset: 0);

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<BadRequestFailure>());

    verify(remoteDataSource.get(path: "characters", params: {
      'limit': 10,
      'offset': 0,
    })).called(1);
    verifyNoMoreInteractions(remoteDataSource);
  });
}
