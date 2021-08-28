import 'package:flutter/material.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        title: Text(
          'My Scores',
          style: ThemeText.titleStyle.copyWith(color: AppColor.secondColor),
        ),
        centerTitle: true,
        backgroundColor: AppColor.personalScheduleColor2,
      ),
      body: Center(
        child: Text(
          'This feature is lauching soon',
          style: ThemeText.titleStyle2
              .copyWith(color: AppColor.personalScheduleColor2),
        ),
      ),
    );
  }
}
