import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:schedule/presentation/journey/home_screen/home_screen_constance.dart';

class AnimationEntity {
  final Duration duration =
      const Duration(milliseconds: HomeScreenConstance.animationDuration);
  final AnimationController controller;
  bool _isCollapsed = true;
  double _borderRadius = 0.0;
  double _addTodoButtonOpacity = 1;

  AnimationEntity({@required this.controller});

  double get addTodoButtonOpacity => _addTodoButtonOpacity;

  set addTodoButtonOpacity(double value) {
    _addTodoButtonOpacity = value;
  }

  double get borderRadius => _borderRadius;

  set borderRadius(double value) {
    _borderRadius = value;
  }

  bool get isCollapsed => _isCollapsed;

  set isCollapsed(bool value) {
    _isCollapsed = value;
  }

  void switchDrawer() {
    if (isCollapsed) {
      controller.forward();
      borderRadius = 16.0;
    } else {
      controller.reverse();
      borderRadius = 0.0;
    }
    isCollapsed = !isCollapsed;
  }

  void closeDrawer() {
    if (!isCollapsed) {
      controller.reverse();
      borderRadius = 0.0;
      isCollapsed = true;
    }
  }

  void setAddTodoButtonBlur() {
    _addTodoButtonOpacity=HomeScreenConstance.addTodoButtonOpacity;
  }
  void resetAddTodoButtonOpacity() {
    _addTodoButtonOpacity=1;
  }

  @override
  String toString() {
    return 'AnimationEntity{duration: $duration, _isCollapsed: $_isCollapsed, _borderRadius: $_borderRadius, _addTodoButtonOpacity: $_addTodoButtonOpacity}';
  }
}
