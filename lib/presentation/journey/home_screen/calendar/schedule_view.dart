import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/ui/views/loading_view.dart';
import 'package:schedule/src/utils/convert.dart';
import 'package:schedule/src/utils/utils.dart';
import 'package:worm_indicator/shape.dart';
import 'package:worm_indicator/worm_indicator.dart';

class ScheduleView extends StatelessWidget {
  PageController _controller = PageController();

  Widget buildPageView() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ScUtil.getInstance().setWidth(50),
          vertical: ScUtil.getInstance().setHeight(20)),
      alignment: Alignment.center,
      child: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _controller,
        itemBuilder: (BuildContext context, index) {
          return BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              if (state is UpdateScheduleDayLoadingState)
                return LoadingView();
              else if (state is UpdateScheduleDaySuccessState) {
                if (index == 0)
                  return _schoolScheduleWidget(state);
                else
                  return _personalScheduleWidget(state);
              } else {
                return SizedBox();
              }
            },
          );
        },
        itemCount: 2,
      ),
    );
  }

  Widget buildExampleIndicatorWithShapeAndBottomPos(
      Shape shape, double bottomPos) {
    return Positioned(
      bottom: bottomPos,
      left: 0,
      right: 0,
      child: WormIndicator(
        length: 2,
        controller: _controller,
        shape: shape,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final circleShape = Shape(
      size: 8,
      shape: DotShape.Circle,
      spacing: 8,
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildPageView(),
            buildExampleIndicatorWithShapeAndBottomPos(circleShape, 8),
          ],
        ),
      ),
    );
  }

  _schoolScheduleWidget(UpdateScheduleDaySuccessState state) {
    List<SchoolSchedule> schoolSchedulesOfDay = state.schedulesSchoolOfDay;
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
//    margin: EdgeInsets.symmetric(vertical: ScUtil.getInstance().setHeight(8)),
      color: Colors.red[100],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: ScUtil.getInstance().setHeight(8),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'School',
                style: TextStyle(
                    fontSize: ScUtil.getInstance().setSp(36),
                    color: Colors.red,
                    fontFamily: 'MR',
                    fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                margin: EdgeInsets.only(left: 4),
                padding: EdgeInsets.all(5),
                child: Text(
                  schoolSchedulesOfDay != null
                      ? '${schoolSchedulesOfDay.length}'
                      : '0',
                  style: TextStyle(
                      fontSize: ScUtil.getInstance().setSp(28),
                      color: Color(0xffFCFAF3),
                      fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          Expanded(
            child: schoolSchedulesOfDay != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: schoolSchedulesOfDay.length,
                    itemBuilder: (context, index) {
                      SchoolSchedule schedule = schoolSchedulesOfDay[index];
                      return _schoolScheduleElementWidget(schedule);
                    })
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Data',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: ScUtil.getInstance().setSp(32),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _schoolScheduleElementWidget(SchoolSchedule schedule) {
    List lessonNumbers = schedule.lesson.split(',');
    String startLesson = lessonNumbers[0];
    String endLesson = lessonNumbers[lessonNumbers.length - 1];
    debugPrint('schoolScheduleElementWidget - address: ${schedule.address}');
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: ScUtil.getInstance().setHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${Convert.startTimeLessonMap[startLesson]}',
                    style: TextStyle(
                        fontSize: ScUtil.getInstance().setSp(32),
                        color: Colors.red,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w600),
                  ),
                  Icon(Icons.arrow_drop_down,
                      color: Colors.red,
                      size: ScUtil.getInstance().setHeight(15)),
                  Text(
                    '${Convert.endTimeLessonMap[endLesson]}',
                    style: TextStyle(
                        fontSize: ScUtil.getInstance().setSp(32),
                        color: Colors.red,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScUtil.getInstance().setWidth(20)),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          width: ScUtil.getInstance().setWidth(1.2),
                          color: Colors.red))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${schedule.subject}',
                    style: TextStyle(
                        fontSize: ScUtil.getInstance().setSp(32),
                        color: Colors.red,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: ScUtil().setHeight(8)),
                  Text(
                    schedule.address.contains('null')
                        ? 'No Data'
                        : '${schedule.address}',
                    style: TextStyle(
                        fontSize: ScUtil.getInstance().setSp(28),
                        color: Colors.red,
                        fontFamily: 'MR',
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _personalScheduleWidget(UpdateScheduleDaySuccessState state) {
    List<PersonalSchedule> personalSchedulesOfDay =
        state.schedulesPersonalOfDay;
    return Card(
      semanticContainer: true,
//      color: Color(0xffFCFAF3),
      color: Colors.blue[100],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: ScUtil.getInstance().setHeight(8),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Personal',
                style: TextStyle(
                    fontSize: ScUtil.getInstance().setSp(36),
                    color: Colors.blue[800],
                    fontFamily: 'MR',
                    fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue[800]),
                margin: EdgeInsets.only(left: 4),
                padding: EdgeInsets.all(5),
                child: Text(
                  personalSchedulesOfDay != null
                      ? '${personalSchedulesOfDay.length}'
                      : '0',
                  style: TextStyle(
                      fontSize: ScUtil.getInstance().setSp(28),
                      color: Color(0xffFCFAF3),
                      fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
          Expanded(
            child: personalSchedulesOfDay != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: personalSchedulesOfDay.length,
                    itemBuilder: (context, index) {
                      PersonalSchedule schedule = personalSchedulesOfDay[index];
                      return InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, '/todo-detail',
                              arguments: schedule.toJson()),
                          child: _personalScheduleElementWidget(schedule));
                    })
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No Data',
                      style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: ScUtil.getInstance().setSp(32),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _personalScheduleElementWidget(PersonalSchedule schedule) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: ScUtil.getInstance().setHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${schedule.timer}',
                style: TextStyle(
                    fontSize: ScUtil.getInstance().setSp(32),
                    color: Colors.blue[800],
                    fontFamily: 'MR',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ScUtil.getInstance().setWidth(20)),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          width: ScUtil.getInstance().setWidth(1.2),
                          color: Colors.blue[800]))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${schedule.name}',
                    style: TextStyle(
                        fontSize: ScUtil.getInstance().setSp(32),
                        color: Colors.blue[800],
                        fontFamily: 'MR',
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${schedule.note}',
                    style: TextStyle(
                        fontSize: ScUtil.getInstance().setSp(32),
                        color: Colors.blue[800],
                        fontFamily: 'MR',
                        fontWeight: FontWeight.normal),
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
