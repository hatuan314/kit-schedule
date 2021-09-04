import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/sign_in_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  AppLocalizations.of(context)!.login,
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

          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 64);
}
