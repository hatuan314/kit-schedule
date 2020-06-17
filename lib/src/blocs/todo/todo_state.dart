part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  final String selectDay;
  final String selectTimer;

  TodoState(this.selectDay, this.selectTimer);
}

class TodoInitState extends TodoState {
  TodoInitState({String selectDay, String selectTimer})
      : super(selectDay, selectTimer);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TodoLoadingState extends TodoState {
  TodoLoadingState({String selectDay, String selectTimer})
      : super(selectDay, selectTimer);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class TodoSuccessState extends TodoState {
  final bool isSuccess;
  TodoSuccessState(this.isSuccess, {String selectDay, String selectTimer})
      : super(selectDay, selectTimer);

  @override
  // TODO: implement props
  List<Object> get props => [this.isSuccess, this.selectDay, this.selectTimer];
}

class TodoFailureState extends TodoState {
  final String error;

  TodoFailureState({this.error, String selectDay, String selectTimer})
      : super(selectDay, selectTimer);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];
}
