import 'package:flutter/material.dart';
import 'package:schedule/common/assets_constance.dart';
import 'package:schedule/src/common/constants/registration_constaint.dart';

class WelcomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 100, right: 100),
          child: Image.asset(
            AssetsConstance.kitScheduleLogo,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            RegistrationConstant.kitScheduleTxt,
            style: TextStyle(
                fontSize: 25,
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
            RegistrationConstant.contentTxt,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withAlpha(70),
              fontFamily: 'MR',
            ),
          ),
        ),
      ],
    );
  }

}