import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable {
}


class OnDrawerChangeEvent extends HomeEvent {
  final int selectIndex;

  OnDrawerChangeEvent(this.selectIndex);

  List<Object> get props => [this.selectIndex];
}
class HomeInitEvent extends HomeEvent{
  final AnimationController animationController;

  HomeInitEvent({@required this.animationController});
  @override
  List<Object> get props => [animationController];
}

class UserTapEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}class SwitchDrawerEvent extends HomeEvent {
  final bool isCollapsed;

  SwitchDrawerEvent({this.isCollapsed});
  @override
  List<Object> get props => [];
}
  class OpenDrawerEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
class SignOutOnPressEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
class ScrollEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
class ScrollStopEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}
class AddTodoEvent extends HomeEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
