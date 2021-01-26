import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';

Widget searchWidget(Function onPress) {
  //final dateTime = _events.keys.elementAt(_events.length - 2);
  return IconButton(
      icon: Icon(
        Icons.search,
        color: ThemeColor.secondColor,
        size: 30,
      ),
      onPressed: onPress,
      );
}