import 'package:flutter/material.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

class ScoresCell extends StatelessWidget {
  const ScoresCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom: BorderSide(color: AppColor.personalScheduleColor))),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: double.maxFinite,
            margin: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: AppColor.personalScheduleColor))),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                'Tiếng Anh 3',
                style: ThemeText.labelStyle.copyWith(fontSize: 15),
              ),
            ),
          )),
          Expanded(
              child: Row(
            children: [
              scoresWidget(),
              scoresWidget(),
              scoresWidget(),
              scoresWidget(isBorderRight: false)
            ],
          ))
        ],
      ),
    );
  }

  Widget scoresWidget({bool isBorderRight = true}) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: isBorderRight
                      ? AppColor.personalScheduleColor
                      : Colors.transparent))),
      alignment: Alignment.center,
      child: Text('4', style: ThemeText.labelStyle.copyWith(fontSize: 15)),
    ));
  }
}
