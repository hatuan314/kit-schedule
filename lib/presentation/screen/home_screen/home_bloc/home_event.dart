import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
}


class OnTabChangeEvent extends HomeEvent {
  final int selectIndex;

  OnTabChangeEvent(this.selectIndex);

  List<Object> get props => [this.selectIndex];
}

class SignOutOnPressEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
