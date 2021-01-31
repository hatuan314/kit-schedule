import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/utils/utils.dart';

import 'button_constances.dart';

class BaseButton extends RaisedButton {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String title;
  final Color color;

  BaseButton({this.onPressed, this.width, this.height, this.title, this.color})
      : super(
          onPressed: onPressed,
          color: color ?? ThemeColor.primaryColor,
          child: Container(
            color: Colors.white,
            width: width ?? double.infinity,
            height: height ?? ScUtil.getInstance().setHeight(36),
            alignment: Alignment.center,
            child: Text(title ?? '', style: ThemeText.textStyle),
          ),
        );
}

class InforButton extends RaisedButton {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String title;
  final Color color;
  final TextStyle textStyle;
  final String icon;

  InforButton(
      {this.icon,
      this.textStyle,
      this.onPressed,
      this.width,
      this.height,
      this.title,
      this.color})
      : super(
          onPressed: onPressed,
          color: color,
          child: Container(
            width: width ?? double.infinity,
            height: ButtonConstance.buttonHeight,
            alignment: Alignment.center,
            child: icon == null
                ? Text(title ?? '',
                    style: textStyle ?? ThemeText.textInforStyle)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        icon,
                        height: ButtonConstance.iconSz,
                        fit: BoxFit.fill,
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              left: ButtonConstance.paddingHorizontal14),
                          child: Text(title ?? '',
                              style: textStyle ?? ThemeText.textInforStyle)),
                    ],
                  ),
          ),
        );
}
