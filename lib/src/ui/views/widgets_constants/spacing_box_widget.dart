import 'package:flutter/cupertino.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class SpacingBoxWidget extends StatelessWidget{
   double height =0;
  //  int width=0;

   SpacingBoxWidget({required this.height });

   @override
  Widget build(BuildContext context) {
   return SizedBox(
   //  width: ,
      height: ScUtil.getInstance()!.setHeight(height),
    );
  }

}