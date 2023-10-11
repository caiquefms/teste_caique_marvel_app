import 'package:dartz/dartz.dart';
import '../../../core/failures/failure.dart';
import '../../../core/infraestruture/datasource/http_client/api_datasource.dart';
import '../models/comic_data_wrapper.dart';

abstract class CharacterDetailRepository {
  Future<Either<Failure, ComicDataWrapper>> getComicsFromCharacter(
      {required int characterId, required int limit, required int offset});
}

class CharacterDetailRepositoryImpl implements CharacterDetailRepository {
  final RemoteDataSource _remoteDatasource;

  CharacterDetailRepositoryImpl({
    required RemoteDataSource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, ComicDataWrapper>> getComicsFromCharacter(
      {required int characterId,
      required int limit,
      required int offset}) async {
    var data = await _remoteDatasource
        .get(path: "characters/$characterId/comics", params: {
      'limit': limit,
      'offset': offset,
    });

    return data.fold(left, (json) => Right(ComicDataWrapper.fromJson(json)));
  }
}
