import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/utils/utils.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    ScUtil.instance = ScUtil(width: 750, height: 1624)..init(context);
    return Scaffold(
      body: Container(
          color: Colors.blue[900],
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
          child: LoadingWidget(
            color: Colors.white,
          )),
    );
  }
}
