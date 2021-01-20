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

class TabChangeState extends HomeState {
  TabChangeState(int selectIndex) : super(selectIndex);

  List<Object> get props => [];
}
class SignOutSuccessState extends HomeState {
  SignOutSuccessState(int selectIndex) : super(selectIndex);
}

class SignOutFailureState extends HomeState {
  SignOutFailureState(int selectIndex) : super(selectIndex);
}
