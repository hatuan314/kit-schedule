import 'package:flutter/material.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

class ButtonWidget extends ElevatedButton {
  final Function()? onPressed;
  final String? title;
  final double? radius;
  final MaterialStateProperty<double?>? elevation;
  final MaterialStateProperty<Color?>? shadow;

  ButtonWidget(
      {this.onPressed,
      this.title,
      this.radius,
      Color color = AppColor.primaryColor,
      this.shadow,
      this.elevation})
      : super(
            onPressed: onPressed,
            child: Container(
              child: Text(
                title!,
                style: ThemeText.buttonLabelStyle,
              ),
            ),
            style: ButtonStyle(
                elevation: elevation,
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius ?? 0))),
                backgroundColor: MaterialStateProperty.all<Color>(color),
                shadowColor: shadow));
}