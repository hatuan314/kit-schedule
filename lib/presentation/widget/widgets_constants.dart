import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/constants/image_constants.dart';

class WidgetsConstants {
  final Widget kitLogo = Image.asset(
    ImageConstants.kitScheduleLogoImage,
    fit: BoxFit.cover,
    width: ScreenUtil().setWidth(50),
  );
}
