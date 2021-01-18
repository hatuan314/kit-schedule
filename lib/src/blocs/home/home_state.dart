part of "home_bloc.dart";

abstract class HomeState extends Equatable {
  final int selectIndex;

  HomeState(this.selectIndex);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomeInitialState extends HomeState {
  HomeInitialState(int selectIndex) : super(selectIndex);

  List<Object> get props => null;
}

class DrawerChangeState extends HomeState {
  DrawerChangeState(int selectIndex) : super(selectIndex);

  List<Object> get props => [this.selectIndex];
}

class SignOutSuccessState extends HomeState {
  SignOutSuccessState(int selectIndex) : super(selectIndex);
}

class SignOutFailureState extends HomeState {
  SignOutFailureState(int selectIndex) : super(selectIndex);
}
