part of "home_bloc.dart";

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class OnTabChangeEvent extends HomeEvent {
  final MainItem mainItem;

  OnTabChangeEvent(this.mainItem);

  List<Object> get props => [this.mainItem];
}

class SignOutOnPressEvent extends HomeEvent {}
