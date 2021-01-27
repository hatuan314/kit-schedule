import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/widgets/event_item_widget.dart';
import 'package:schedule/presentation/screen/search_screen/search_screen_constance.dart';
import 'package:schedule/presentation/widgets/event_detail.dart';

class SearchEventItem extends StatelessWidget {
  final List schedule;

  const SearchEventItem({Key key, this.schedule}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
          child: Row(
            children: [
              Text(
                '15-01-2021',
                style: ThemeText.textStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: ThemeColor.primaryColor,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(
          width: 20.w,
        ),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            primary: false,
            itemCount: 5,
            itemBuilder: (context, index) => (true)? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: EventItemWidget(
                startTime: '7:00',
                title: 'Todo',
                note: 'note',
                onTap: (){
                  showDialog(
                      context: context,builder: (_) => EventDetail(
                  ));
                },
              ),
            ) :
                ListTile(
              onTap: (){
                showDialog(
                    context: context,builder: (_) => EventDetail(
                ));
              },
                  title: Text(
                    "Todo",
                    style: ThemeText.textStyle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '20:00',
                    style: ThemeText.textStyle.copyWith(fontSize: SearchScreenConstance.noteSize),
                  ),
                )),
      ],
    );
  }
}
