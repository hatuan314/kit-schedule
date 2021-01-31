import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/presentation/journey/welcome/widgets/group_buttons.dart';
import 'package:schedule/presentation/journey/welcome/widgets/header.dart';

class Infor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.primaryColor,
      body: ListView(
        padding: EdgeInsets.only(top: 200, left: 20, right: 20),
        children: [
          WelcomeHeader(),
          SizedBox(
            height: 40,
          ),
          GroupButtons(
            signIn: () => signIn(context),
            signInGoogle: () => signInGoogle(context),
            signInFb: () => signInFb(context),
          ),
        ],
      ),
    );
  }

  void signIn(BuildContext context) {}

  void signInGoogle(BuildContext context) {}

  void signInFb(BuildContext context) {}
}
