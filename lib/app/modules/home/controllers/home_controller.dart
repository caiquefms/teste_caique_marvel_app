import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import '../../../core/infraestruture/datasource/http_client/api_datasource.dart';
import '../../../core/infraestruture/local_storage/secure_local_storage.dart';
import '../../../core/infraestruture/log/logger.dart';
import "../../../core/presentation/state/state_result.dart";
import '../entity/character.dart';
import '../usecases/get_character_usecase.dart';
import '../repositories/home_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GetCharacterUseCase _useCase = GetCharacterUseCase(HomeRepositoryImpl(
      remoteDatasource: ApiDataSource(
          client: Dio(),
          localStorage: SecureLocalStorage(),
          logger: Logger())));

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

  Future<void> getCharacters() async {
    try {
      setState(LoadingStateResult());

      var result = await _useCase.call(limit: _limit, offset: _offset);

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

  Future<void> getCharactersPaged() async {
    try {
      _paginationError = false;
      _isLoading = true;
      _offset += limit;

      var result = await _useCase.call(limit: _limit, offset: _offset);

      result.fold((l) {
        _paginationError = true;
        _isLoading = false;
        _offset -= limit;
      }, (r) {
        _isLoading = false;
        var list = (state as SuccessStateResult<List<Character>>).data;
        list.addAll(r.items);
        setState(SuccessStateResult(list));
      });
    } on Exception catch (e) {
      setState(ExceptionStateResult(e));
    }
  }
}
