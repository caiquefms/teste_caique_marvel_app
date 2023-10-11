import 'package:dartz/dartz.dart';
import '../../../core/extensions/either_extension.dart';
import '../../../core/failures/failure.dart';
import '../../character_detail/entity/page.dart';
import '../repositories/home_repository.dart';
import '../entity/character.dart';

class GetCharacterUseCase {
  final HomeRepository _repository;

  GetCharacterUseCase(this._repository);

  Future<Either<Failure, Page<Character>>> call(
      {required int limit, required int offset}) async {
    var result = await _repository.getCharacters(limit: limit, offset: offset);
    if (result.isLeft()) {
      return Left(result.asLeft());
    }
    return Right(Page<Character>(
        total: result.asRight().data!.total ?? 0,
        items: result
                .asRight()
                .data
                ?.results
                ?.map((model) => Character(
                    characterId: model.id ?? 0,
                    name: model.name ?? "",
                    thumbnail: model.thumbnail?.path ?? "",
                    description: model.description ?? "",
                    numberComics: model.comics?.available ?? 0,
                    numberSeries: model.series?.available ?? 0,
                    numberStories: model.stories?.available ?? 0,
                    numberEvents: model.events?.available ?? 0))
                .toList() ??
            []));
  }
}
