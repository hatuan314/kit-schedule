import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:schedule/src/utils/utils.dart';

class WidgetsConstants{
  final Widget kitLogo = Image.asset(
    'assets/img/kit_schedule_logo.png',
    fit: BoxFit.cover,
    width: ScUtil.getInstance()!.setWidth(50),
  );

}