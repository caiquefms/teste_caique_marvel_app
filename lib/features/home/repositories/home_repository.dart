import 'package:dartz/dartz.dart';
import '../models/character_data_wrapper.dart';
import '../../../core/failures/failure.dart';
import '../../../core/infraestruture/datasource/http_client/api_datasource.dart';

abstract class HomeRepository {
  Future<Either<Failure, CharacterDataWrapper>> getCharacters(
      {required int limit, required int offset});
}

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSource _remoteDataSource;

  HomeRepositoryImpl({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, CharacterDataWrapper>> getCharacters(
      {required int limit, required int offset}) async {
    var data = await _remoteDataSource.get(path: "characters", params: {
      'limit': limit,
      'offset': offset,
    });

    return data.fold(
        left, (json) => Right(CharacterDataWrapper.fromJson(json)));
  }
}
