import 'package:flutter/material.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
import 'package:schedule/src/utils/utils.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    ScUtil.instance = ScUtil(width: 750, height: 1624)..init(context);
    return Scaffold(
      body: Container(
          color: Colors.blue[900],
          margin: EdgeInsets.only(top: ScUtil.getInstance().setHeight(50)),
          child: LoadingWidget()),
    );
  }
}
