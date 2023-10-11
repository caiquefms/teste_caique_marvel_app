import '../../failures/failure.dart';

abstract class StateResult {}

class LoadingStateResult extends StateResult {}

class SuccessStateResult<T> extends StateResult {
  final T data;

  SuccessStateResult(this.data);
}

class ExceptionStateResult extends StateResult {
  final Exception exception;

  ExceptionStateResult(this.exception);
}

class FailureStateResult extends StateResult {
  final Failure failure;

  FailureStateResult(this.failure);
}
