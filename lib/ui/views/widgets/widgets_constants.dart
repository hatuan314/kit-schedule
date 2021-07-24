import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/utils/utils.dart';

class WidgetsConstants{
  final Widget kitLogo = Image.asset(
    'assets/img/kit_schedule_logo.png',
    fit: BoxFit.cover,
    width: ScreenUtil()!.setWidth(50),
  );

}