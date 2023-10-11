import 'package:flutter/material.dart';
import '../../failures/failure.dart';
import 'state_result.dart';

typedef BuildLoadingState = Widget Function();
typedef BuildSuccessState<R> = Widget Function(R result);
typedef BuildFailureState = Widget Function(Failure failure);
typedef BuildExceptionState = Widget Function(Exception ex);

Widget getStateResultSwitcher<T>(
    {required StateResult state,
    required BuildLoadingState buildLoadingState,
    required BuildSuccessState<T> buildSuccessState,
    required BuildFailureState buildFailureState,
    required BuildExceptionState buildExceptionState,
    Duration animDuration = const Duration(milliseconds: 500),
    Curve switchInCurve = Curves.fastOutSlowIn,
    Curve switchOutCurve = Curves.fastOutSlowIn}) {
  Widget widgetState = SizedBox();

  if (state is LoadingStateResult) {
    widgetState = buildLoadingState.call();
  }

  if (state is SuccessStateResult) {
    widgetState = buildSuccessState.call(state.data);
  }

  if (state is FailureStateResult) {
    widgetState = buildFailureState.call(state.failure);
  }

  if (state is ExceptionStateResult) {
    widgetState = buildExceptionState.call(state.exception);
  }

  return AnimatedSwitcher(
    duration: animDuration,
    switchInCurve: switchInCurve,
    switchOutCurve: switchOutCurve,
    child: widgetState,
  );
}
