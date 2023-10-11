import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:teste_caique_marvel_app/core/failures/http_failures.dart';
import 'package:teste_caique_marvel_app/features/character_detail/entity/page.dart';
import 'package:teste_caique_marvel_app/features/home/repositories/home_repository.dart';
import 'package:teste_caique_marvel_app/features/home/usecases/get_character_usecase.dart';

import '../data_mocks.dart';
import 'get_character_usecase.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late HomeRepository repository;
  late GetCharacterUseCase useCase;

  setUp(() {
    repository = MockHomeRepository();
    useCase = GetCharacterUseCase(repository);
  });

  test('Deve retornar um Right de Comic', () async {
    when(repository.getCharacters(
      limit: 10,
      offset: 0,
    )).thenAnswer((_) async => Right(model_characters));

    final result = await useCase.call(limit: 10, offset: 0);

    expect(result, isA<Right>());
    expect(result.fold(id, id), isA<Page>());

    verify(repository.getCharacters(
      limit: 10,
      offset: 0,
    )).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('Deve retornar um Left de Failure', () async {
    when(repository.getCharacters(
      limit: 10,
      offset: 0,
    )).thenAnswer((_) async => Left(BadRequestFailure(message: "")));

    final result = await useCase.call(limit: 10, offset: 0);

    expect(result, isA<Left>());
    expect(result.fold(id, id), isA<BadRequestFailure>());

    verify(repository.getCharacters(
      limit: 10,
      offset: 0,
    )).called(1);
    verifyNoMoreInteractions(repository);
  });
}
