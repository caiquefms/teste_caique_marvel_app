import 'dart:io';
import 'package:logger/logger.dart' as logLib;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobx/mobx.dart';
import '../../../core/infraestruture/datasource/http_client/api_datasource.dart';
import '../../../core/infraestruture/local_storage/secure_local_storage.dart';
import '../../../core/presentation/state/state_result.dart';
import '../../../core/infraestruture/log/logger.dart';
import '../repositories/detalhes_personagem_repository.dart';
import '../usecases/get_comics_usecase.dart';
import '../entity/comic.dart';

part 'character_detail_controller.g.dart';

class CharacterDetailController = _CharacterDetailControllerBase
    with _$CharacterDetailController;

abstract class _CharacterDetailControllerBase with Store {
  final GetComicsUseCase _useCase =
      GetComicsUseCase(CharacterDetailRepositoryImpl(
          remoteDatasource: ApiDataSource(
              client: Dio(),
              localStorage: SecureLocalStorage(Platform.isAndroid
                  ? FlutterSecureStorage(
                      aOptions:
                          AndroidOptions(encryptedSharedPreferences: true),
                    )
                  : FlutterSecureStorage(iOptions: IOSOptions())),
              logger: Logger(logLib.Logger()))));

  @observable
  StateResult _state = LoadingStateResult();
  @computed
  StateResult get state => _state;
  @action
  StateResult setState(StateResult state) => this._state = state;

  @observable
  bool _paginationError = false;
  @computed
  bool get paginationError => _paginationError;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _limit = 10;
  int get limit => _limit;

  int _offset = 0;
  int get offset => _offset;

  int _totalElements = 0;
  int get totalElements => _totalElements;

  int _characterId = -1;

  Future<void> getComics(int characterId) async {
    try {
      _characterId = characterId;
      setState(LoadingStateResult());

      var result = await _useCase.call(
          characterId: _characterId, limit: _limit, offset: _offset);

      result.fold((l) {
        setState(FailureStateResult(l));
      }, (r) {
        _totalElements = r.total;
        setState(SuccessStateResult(r.items));
      });
    } on Exception catch (e) {
      setState(ExceptionStateResult(e));
    }
  }

  Future<void> getComicsPaged() async {
    try {
      _paginationError = false;
      _isLoading = true;
      _offset += limit;

      var result = await _useCase.call(
          characterId: _characterId, limit: _limit, offset: _offset);

      result.fold((l) {
        _paginationError = true;
        _isLoading = false;
        _offset -= limit;
      }, (r) {
        _isLoading = false;
        var list = (state as SuccessStateResult<List<Comic>>).data;
        list.addAll(r.items);
        setState(SuccessStateResult(list));
      });
    } on Exception catch (e) {
      setState(ExceptionStateResult(e));
    }
  }
}
