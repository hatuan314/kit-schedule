import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/widget/loader_widget/loader_constants.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      width: 60.w,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        key: ValueKey(LoaderConstants.loaderImageKey),
        color: AppColor.primaryColor,
      ),
    );
  }
}