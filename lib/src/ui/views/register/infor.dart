import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/common/constants/registration_constaint.dart';
import 'package:schedule/src/common/widgets/base_button.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';
class Infor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.black,
     body:ListView (
      padding: EdgeInsets.only(top: 200,left: 20,right: 20),
       children: [
         Container(
           padding: EdgeInsets.only(left: 100,right: 100),
           child: Image.asset(
            'assets/img/kit_schedule_logo.png',

        ),
         ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'KIT Schedule',
            style: TextStyle(
                fontSize:25,
                color: Colors.white,
                fontFamily: 'MR',
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Manage your School Schedule',
            style: TextStyle(
                fontSize: 15,
                color: Colors.white.withAlpha(70),
                fontFamily: 'MR',
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          child: InforButton(
              title : RegistrationConstant.signUpEmailBtn,
              color: ThemeColor.signUpEmailButtonColor,
            textStyle: ThemeText.textInforStyle.copyWith(
             color: Colors.white,

            ),


          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: InforButton(
              title :RegistrationConstant.signUpGoogleBtn,
              color: ThemeColor.signUpButtonColor,
            icon:  'assets/img/ic_google.png',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: InforButton(
              title: RegistrationConstant.signUpFbBtn,
              color: ThemeColor.signUpButtonColor,
              icon:  'assets/img/ic_fb.png',
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Text(
              RegistrationConstant.alreadyAccount,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontFamily: 'MR',
              ),

            ),
            RichText(
              text: TextSpan(
                text: 'Sign In',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontFamily: 'MR',
                  ),
              ),
              ),
          ],
        )
      ],
     ),
   );
  }
}
