import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:schedule/presentation/journey/home_screen/home_screen_constance.dart';

class AnimationEntity {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: HomeScreenConstance.animationDuration);
  final AnimationController controller;
  double borderRadius = 0.0;

  AnimationEntity({@required this.controller});
}