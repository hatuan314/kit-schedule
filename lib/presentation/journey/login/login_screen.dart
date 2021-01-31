import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/common/constants/registration_constaint.dart';
import 'package:schedule/src/common/widgets/button/base_button.dart';
import 'package:schedule/src/common/widgets/base_text_form.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: ListView(

       children: [
         Container(
           padding: EdgeInsets.only(top: 200,left: 15),
           child: Text(
             'Welcome back !',
             style: TextStyle(
                 fontSize:20,
                 color: Colors.white,
                 fontFamily: 'MR',
                 fontWeight: FontWeight.w600),

           ),

         ),
         SizedBox(
           height: 20,
         ),
         Container(
          padding: EdgeInsets.only(left: 15),
           child: Text(
             'Sign in with ACTVN account',
             style: TextStyle(
               fontSize: 13,
               color: Colors.white.withAlpha(70),
               fontFamily: 'MR',
             ),
           ),
         ),
         SizedBox(
           height: 20,
         ),
         Container(
           padding: EdgeInsets.symmetric(horizontal: 10),
           child: LoginTextField(
             labelText:RegistrationConstant.account,
             iconData: Icons.account_circle,
           ),
         ),
          SizedBox(
          height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(

                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  LoginTextField(
                labelText: RegistrationConstant.password,
                iconData: Icons.lock,
                ),
                IconButton(
                icon: Icon(Icons.visibility_off,
                color: Colors.white,
                ),

                ),

              ],

     ),
          ),
         SizedBox(
           height: 8,
         ),
         Container(
           padding: EdgeInsets.only(right: 10),
           child: RichText(
             textAlign: TextAlign.end,
             text: TextSpan(
               text: 'Forget password?',
               style: TextStyle(
                 color: Colors.white,
                 fontFamily: 'MR',
               ),
             ),
           ),
         ),
         SizedBox(
           height: 16,
         ),
         Container(
           margin: EdgeInsets.symmetric(horizontal: 10),
           child:RaisedButton(
             padding: EdgeInsets.only(top: 13,bottom: 13),
             child: Text( RegistrationConstant.signInBtn,
                style: ThemeText.textInforStyle.copyWith(
                  color: ThemeColor.secondColor,
                ),

             ),
             color: ThemeColor.signInButtonColor,
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(5.0))),
             onPressed: () {},
           ),
         ),
  ],
   ),
    );
  }
}
