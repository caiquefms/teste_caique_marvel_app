import 'package:dartz/dartz.dart';
import '../models/character_data_wrapper.dart';
import '../../../core/failures/failure.dart';
import '../../../core/infraestruture/datasource/http_client/api_datasource.dart';

abstract class HomeRepository {
  Future<Either<Failure, CharacterDataWrapper>> getCharacters(
      {required int limit, required int offset});
}

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSource _remoteDatasource;

  HomeRepositoryImpl({
    required RemoteDataSource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, CharacterDataWrapper>> getCharacters(
      {required int limit, required int offset}) async {
    var data = await _remoteDatasource.get(path: "characters", params: {
      'limit': limit,
      'offset': offset,
    });

    return data.fold(
        left, (json) => Right(CharacterDataWrapper.fromJson(json)));
  }
}
