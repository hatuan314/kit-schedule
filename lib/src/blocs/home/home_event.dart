part of "home_bloc.dart";

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OnTabChangeEvent extends HomeEvent {
  final int selectIndex;

  OnTabChangeEvent(this.selectIndex);

  List<Object> get props => [this.selectIndex];
}

class SignOutOnPressEvent extends HomeEvent {}
