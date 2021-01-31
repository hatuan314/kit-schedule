import 'package:flutter/widgets.dart';
import 'package:schedule/common/assets_constance.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/src/common/constants/registration_constaint.dart';
import 'package:schedule/src/common/widgets/button/base_button.dart';

class GroupButtons extends StatelessWidget {
  final Function signIn;
  final Function signInGoogle;
  final Function signInFb;

  const GroupButtons({Key key, this.signIn, this.signInGoogle, this.signInFb}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InforButton(
            title: RegistrationConstant.signUpEmailBtn,
            color: ThemeColor.signUpEmailButtonColor,
            textStyle: ThemeText.getDefaultTextTheme.button.copyWith(color: ThemeColor.secondColor),
            onPressed: signIn),
        SizedBox(
          height: 10,
        ),
        InforButton(
          title: RegistrationConstant.signUpGoogleBtn,
          color: ThemeColor.signUpButtonColor,
          icon: 'assets/img/ic_google.png',
          onPressed: signInGoogle,
          textStyle: ThemeText.getDefaultTextTheme.button,
        ),
        SizedBox(
          height: 10,
        ),
        InforButton(
          title: RegistrationConstant.signUpFbBtn,
          color: ThemeColor.signUpButtonColor,
          icon: AssetsConstance.fbIcon,
          onPressed: signInFb,
          textStyle: ThemeText.getDefaultTextTheme.button,
        ),
      ],
    );
  }

}