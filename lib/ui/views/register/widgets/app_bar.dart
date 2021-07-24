import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../sign_in_constains.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: SignInConstains.horizontalScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  SignInConstains.loginTxt,
                  style: TextStyle(
                      fontFamily: "MR",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: SignInConstains.sizeLoginTxt),
                ),
                SizedBox(
                  height:  5.h,
                ),
                Container(
                  width: SignInConstains.widthLineLogin,
                  height: SignInConstains.heightLineLogin,
                  decoration: BoxDecoration(
                      color: SignInConstains.colorDefault,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ],
            ),
            // Container(
            //   height: SignInConstains.sizeIconKit,
            //   width:  SignInConstains.sizeIconKit,
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage('assets/img/kit_schedule_logo.png'))),
            // )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 64);
}
