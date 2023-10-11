import 'package:dartz/dartz.dart';
import '../../../core/extensions/either_extension.dart';
import '../../../core/failures/failure.dart';
import '../repositories/detalhes_personagem_repository.dart';
import '../entity/price.dart';
import '../entity/comic.dart';
import '../entity/page.dart';

class GetComicsUseCase {
  final CharacterDetailRepository _repository;

  GetComicsUseCase(this._repository);

  Future<Either<Failure, Page<Comic>>> call(
      {required int characterId,
      required int limit,
      required int offset}) async {
    var result = await _repository.getComicsFromCharacter(
        characterId: characterId, limit: limit, offset: offset);
    if (result.isLeft()) {
      return Left(result.asLeft());
    }
    return Right(Page<Comic>(
        total: result.asRight().data!.total ?? 0,
        items: result
                .asRight()
                .data
                ?.results
                ?.map((model) => Comic(
                    title: model.title ?? "",
                    description: model.description ?? "",
                    thumbnail: model.thumbnail?.path ?? "",
                    issueNumber: model.issueNumber ?? 0,
                    pageCount: model.pageCount ?? 0,
                    prices: model.prices
                            ?.map((price) => Price(
                                type: price.type ?? "",
                                price: price.price ?? 0))
                            .toList() ??
                        [],
                    creators: model.creators?.items
                            ?.map((item) => item.name ?? "")
                            .toList() ??
                        []))
                .toList() ??
            []));
  }
}
