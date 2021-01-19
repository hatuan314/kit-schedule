import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:schedule/domain/entities/animation_entities.dart';
abstract class HomeState extends Equatable{

}

class HomeInitialState extends HomeState {
  final AnimationEntity animationEntity;

  HomeInitialState({this.animationEntity});
  List<Object> get props => [animationEntity];
}

class HomeOnChangeTabState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class AddTodoState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class HomeLoadingState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SwitchDrawerState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class OpenDrawerState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class SignOutSuccessState extends HomeState {

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SignOutFailureState extends HomeState {

  @override
  // TODO: implement props
  List<Object> get props => null;
}
