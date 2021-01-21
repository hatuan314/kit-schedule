import 'package:flutter/material.dart';

class ColonWidget extends StatelessWidget {
  const ColonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red),
    );
  }
}