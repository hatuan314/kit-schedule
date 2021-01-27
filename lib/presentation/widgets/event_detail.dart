import 'package:flutter/material.dart';
import 'package:schedule/common/app_constance.dart';
import 'package:schedule/common/themes/theme_border.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';

class EventDetail extends StatelessWidget {
  final Function delete;
  final Function edit;
  final String title;
  final String date;
  final String time;
  final String note;

  const EventDetail(
      {Key key,
      this.delete,
      this.edit,
      this.title,
      this.note,
      this.date,
      this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: ThemeColor.secondColor,
          border: Border.all(
              color: ThemeBorder.borderColor, width: ThemeBorder.borderWidth),
          borderRadius: ThemeBorder.borderRadiusAll,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: AppConstance.iconSize,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppConstance.detailPadding,
                    vertical: AppConstance.detailPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: ThemeText.textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstance.titleTextSize),
                    ),
                    SizedBox(
                      height: AppConstance.sizeBoxHeight,
                    ),
                    Row(
                      children: [
                        Text(
                          '10/01/2021',
                          style: ThemeText.textStyle,
                        ),
                        Text(
                          '16 : 00',
                          style: ThemeText.textStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppConstance.sizeBoxHeight,
                    ),
                    SingleChildScrollView(
                      child: Text(
                        'Note detail ....',
                        style: ThemeText.textStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppConstance.detailPadding,
                  horizontal: AppConstance.detailPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: AppConstance.iconSize,
                        color: Colors.redAccent,
                      ),
                      onPressed: delete),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: AppConstance.iconSize,
                        color: ThemeColor.primaryColor,
                      ),
                      onPressed: edit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
