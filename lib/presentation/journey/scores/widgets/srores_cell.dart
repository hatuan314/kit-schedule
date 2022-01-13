import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/presentation/journey/scores/scores_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoresCell extends StatelessWidget {
  const ScoresCell(
      {Key? key,
      required this.subject,
      required this.scoreIn4,
      required this.letterScore,
      required this.credits})
      : super(key: key);
  final String subject;
  final int credits;
  final double scoreIn4;
  final String letterScore;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              bottom: BorderSide(color: AppColor.personalScheduleColor))),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: scoresWidget(score: subject),
          ),
          Expanded(
            flex: 2,
            child: scoresWidget(score: credits.toString()),
          ),
          Expanded(
            flex: 1,
            child: scoresWidget(score: scoreIn4.toString()),
          ),
          Expanded(
            flex: 1,
            child: scoresWidget(score: letterScore.toString()),
          ),
        ],
      ),
    );
  }

  Widget scoresWidget({bool isBorderRight = true, required String score}) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
          border: Border(
              right: BorderSide(
                  color: isBorderRight
                      ? AppColor.personalScheduleColor
                      : Colors.transparent))),
      alignment: Alignment.center,
      child: Text(score,
          textAlign: TextAlign.center,
          style: ThemeText.labelStyle
              .copyWith(fontSize: ScoresConstants.scoreFontSize)),
    );
  }
}
