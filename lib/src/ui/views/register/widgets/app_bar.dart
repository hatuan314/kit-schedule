import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: ScUtil.getInstance()!.setSp(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                      fontFamily: "MR",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 25.sp),
                ),
                SizedBox(
                  height:  5.h,
                ),
                Container(
                  width: 50.w,
                  height: 2.5.h,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ],
            ),
            Container(
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/kit_schedule_logo.png'))),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 64);
}
// appBar: AppBar(
// backgroundColor: Colors.transparent,
// elevation: 0,
// leading: Column(
// children: [
// Text('Login',style: TextStyle(
// fontFamily: "MR",
// color: Colors.black,
// fontWeight: FontWeight.w600
// ),),
// SizedBox(
// height: 5,
// ),
// Container(
// width: 40,
// height: 3,
// decoration: BoxDecoration(
// color: Colors.red,
// borderRadius: BorderRadius.all(Radius.circular(10))),
// ),
// ],
// ),
// ),
