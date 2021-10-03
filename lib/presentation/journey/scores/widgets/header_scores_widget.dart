import 'package:flutter/material.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

class HeaderScoresWidget extends StatelessWidget {
  const HeaderScoresWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColor.personalScheduleColor))),
      child: Row(
        children: [
          nameBoard('Môn học'),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  nameBoard('Số TC'),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                      right: BorderSide(
                                          color:
                                              AppColor.personalScheduleColor),
                                      bottom: BorderSide(
                                          color:
                                              AppColor.personalScheduleColor))),
                              alignment: Alignment.center,
                              child: Text(
                                'Điểm số',
                                style: ThemeText.headerStyle2
                                    .copyWith(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [nameBoard('Hệ 10'), nameBoard('Hệ 4')],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  nameBoard('Điểm chữ', isBorderRight: false)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nameBoard(String title, {bool isBorderRight = true}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
                right: BorderSide(
                    color: isBorderRight
                        ? AppColor.personalScheduleColor
                        : Colors.transparent))),
        alignment: Alignment.center,
        child: Text(
          title,
          style: ThemeText.headerStyle2.copyWith(fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
