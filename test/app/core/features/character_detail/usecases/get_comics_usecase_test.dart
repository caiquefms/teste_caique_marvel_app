import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_caique_marvel_app/core/failures/http_failures.dart';
import 'package:teste_caique_marvel_app/features/character_detail/entity/page.dart';
import 'package:teste_caique_marvel_app/features/character_detail/repositories/detalhes_personagem_repository.dart';
import 'package:teste_caique_marvel_app/features/character_detail/usecases/get_comics_usecase.dart';

import '../data_mocks.dart';
import 'get_comics_usecase_test.mocks.dart';

@GenerateMocks([CharacterDetailRepository])
void main() {
  late CharacterDetailRepository repository;
  late GetComicsUseCase useCase;

  setUp(() {
    repository = MockCharacterDetailRepository();
    useCase = GetComicsUseCase(repository);
  });

  test('Deve retornar um Right de Comic', () async {
    when(repository.getComicsFromCharacter(
      characterId: 1,
      limit: 10,
      offset: 0,
    )).thenAnswer((_) async => Right(model_comics));

    final result = await useCase.call(characterId: 1, limit: 10, offset: 0);

    expect(result, isA<Right>());
    expect(result.fold(id, id), isA<Page>());

    verify(repository.getComicsFromCharacter(
      characterId: 1,
      limit: 10,
      offset: 0,
    )).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('Deve retornar um Left de Failure', () async {
    when(repository.getComicsFromCharacter(
      characterId: 1,
      limit: 10,
      offset: 0,
    )).thenAnswer((_) async => Left(BadRequestFailure(message: "")));

    final result = await useCase.call(characterId: 1, limit: 10, offset: 0);

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<BadRequestFailure>());

    verify(repository.getComicsFromCharacter(
      characterId: 1,
      limit: 10,
      offset: 0,
    )).called(1);
    verifyNoMoreInteractions(repository);
  });
}
