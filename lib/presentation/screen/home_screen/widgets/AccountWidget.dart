
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/screen/home_screen/home_screen_constance.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.account_circle,
            size: HomeScreenConstance.accountIconSize,
          ),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Phạm Doãn Hiếu',
                style: ThemeText.accountTextStyle),
            Text(
              'MSV: CT030419',
              style: ThemeText.accountTextStyle,
            )
          ],
        ),
      ],
    );
  }
}
