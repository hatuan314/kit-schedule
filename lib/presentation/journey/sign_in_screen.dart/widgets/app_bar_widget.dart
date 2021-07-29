import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/sign_in_constants.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin:
        EdgeInsets.symmetric(horizontal: SignInConstants.horizontalScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  SignInConstants.loginTxt,
                  style: TextStyle(
                      fontFamily: "MR",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: SignInConstants.sizeLoginTxt),
                ),
                SizedBox(
                  height:  5.h,
                ),
                Container(
                  width: SignInConstants.widthLineLogin,
                  height: SignInConstants.heightLineLogin,
                  decoration: BoxDecoration(
                      color: SignInConstants.colorDefault,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ],
            ),
            // Container(
            //   height: SignInConstants.sizeIconKit,
            //   width:  SignInConstants.sizeIconKit,
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
