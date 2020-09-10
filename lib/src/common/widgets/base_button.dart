import 'package:flutter/material.dart';
import 'package:schedule/src/common/themes/theme_color.dart';
import 'package:schedule/src/common/themes/theme_text.dart';
import 'package:schedule/src/utils/utils.dart';

class BaseButton extends RaisedButton {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String title;
  final Color color;

  BaseButton({this.onPressed, this.width, this.height, this.title, this.color}) :
  super(onPressed: onPressed,
        color: color ?? ThemeColor.primaryColor,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? ScUtil.getInstance().setHeight(36),
          alignment: Alignment.center,
          child: Text(title ?? '', style: ThemeText.buttonStyle),
        ),);


}