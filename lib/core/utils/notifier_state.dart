import 'package:autotureid/core/enums.dart';

class NotifierState<T> {
  T? value;
  String? failure;
  RequestState state;

  NotifierState({
    this.value,
    this.failure,
    this.state = RequestState.initial,
  });

  void setSuccess({T? value}) {
    state = RequestState.success;
    this.value = value;
  }

  void setError({String? error}) {
    state = RequestState.error;
    failure = error;
  }

  void setLoading() {
    state = RequestState.loading;
  }

  void reset() {
    state = RequestState.initial;
    failure = null;
    value = null;
  }

  bool isSuccess() {
    return state == RequestState.success;
  }

  bool isError() {
    return state == RequestState.error;
  }

  bool isLoading() {
    return state == RequestState.loading;
  }

  bool isInitial() {
    return state == RequestState.initial;
  }
}
