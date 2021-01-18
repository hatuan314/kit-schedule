part of "home_bloc.dart";

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OnTabDrawerEvent extends HomeEvent {
  final int selectIndex;

  OnTabDrawerEvent(this.selectIndex);

  List<Object> get props => [this.selectIndex];
}

class SignOutOnPressEvent extends HomeEvent {}

class AddTodoEvent extends HomeEvent {}
