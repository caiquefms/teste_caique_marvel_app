import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_caique_marvel_app/core/failures/http_failures.dart';
import 'package:teste_caique_marvel_app/core/infraestruture/datasource/http_client/api_datasource.dart';
import 'package:teste_caique_marvel_app/features/character_detail/models/comic_data_wrapper.dart';
import 'package:teste_caique_marvel_app/features/character_detail/repositories/detalhes_personagem_repository.dart';
import '../data_mocks.dart';

import 'detalhes_personagem_repository_test.mocks.dart';

@GenerateMocks([RemoteDataSource])
void main() {
  late RemoteDataSource remoteDataSource;
  late CharacterDetailRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDataSource = MockRemoteDataSource();
    repositoryImpl =
        CharacterDetailRepositoryImpl(remoteDatasource: remoteDataSource);
  });

  test('Deve retornar um Right de ComicDataWrapper', () async {
    when(remoteDataSource.get(path: "characters/0/comics", params: {
      'limit': 10,
      'offset': 0,
    })).thenAnswer((_) async => Right(json_comics));

    final result = await repositoryImpl.getComicsFromCharacter(
        characterId: 0, limit: 10, offset: 0);

    expect(result, isA<Right>());
    expect(result.fold(id, id), isA<ComicDataWrapper>());

    verify(remoteDataSource.get(path: "characters/0/comics", params: {
      'limit': 10,
      'offset': 0,
    })).called(1);
    verifyNoMoreInteractions(remoteDataSource);
  });

  test('Deve retornar um Left de Failure', () async {
    when(remoteDataSource.get(path: "characters/0/comics", params: {
      'limit': 10,
      'offset': 0,
    })).thenAnswer((_) async => Left(BadRequestFailure(message: "")));

    final result = await repositoryImpl.getComicsFromCharacter(
        characterId: 0, limit: 10, offset: 0);

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<BadRequestFailure>());

    verify(remoteDataSource.get(path: "characters/0/comics", params: {
      'limit': 10,
      'offset': 0,
    })).called(1);
    verifyNoMoreInteractions(remoteDataSource);
  });
}
