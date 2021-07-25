import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpacingBoxWidget extends StatelessWidget{
   final double height;
  //  int width=0;

   SpacingBoxWidget({required this.height});

   @override
  Widget build(BuildContext context) {
   return SizedBox(
   //  width: ,
      height: height.h,
    );
  }

}