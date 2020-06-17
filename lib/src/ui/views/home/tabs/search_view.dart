import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:schedule/src/blocs/blocs.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/ui/views/views.dart';
import 'package:schedule/src/utils/utils.dart';
import 'package:worm_indicator/indicator.dart';
import 'package:worm_indicator/shape.dart';

class SearchView extends StatelessWidget {
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final circleShape = Shape(
      size: 8,
      shape: DotShape.Circle,
      spacing: 8,
    );
    return Scaffold(
      backgroundColor: Color(0xffFCFAF3),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchSuccessState) {

          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 85,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    _buildPageView(state),
                    buildExampleIndicatorWithShapeAndBottomPos(circleShape, 8),
                  ],
                ),
              ),
              Expanded(
                flex: 15,
                child: _searchWidget(context, state),
              )
            ],
          );
        }),
      ),
    );
  }

  Padding _searchWidget(BuildContext context, SearchState state) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: ScUtil.getInstance().setWidth(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Search by date',
            style: TextStyle(
                color: Colors.black54,
                fontSize: ScUtil.getInstance().setSp(38),
                fontFamily: 'MR',
                fontWeight: FontWeight.w600),
          ),
          InkWell(
            onTap: () => _btnSearchOnPress(context),
            child: Container(
              width: double.infinity,
              margin:
                  EdgeInsets.only(bottom: ScUtil.getInstance().setHeight(12)),
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: Colors.black38,
                            width: ScUtil.getInstance().setWidth(2))),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: ScUtil.getInstance().setHeight(12)),
                    child: Text(
                      '${state.selectDay}',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScUtil.getInstance().setSp(32),
                          fontFamily: 'MR',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScUtil.getInstance().setWidth(20)),
                    child: Icon(
                      Icons.search,
                      color: Colors.black54,
                      size: ScUtil.getInstance().setSp(50),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
        controller: _pageController,
        shape: shape,
      ),
    );
  }

  _buildPageView(SearchState state) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: ScUtil.getInstance().setHeight(50)),
      padding: EdgeInsets.symmetric(
          horizontal: ScUtil.getInstance().setWidth(50),
          vertical: ScUtil.getInstance().setHeight(20)),
      alignment: Alignment.center,
      child: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: _pageController,
        itemBuilder: (BuildContext context, index) {
          if (state is SearchLoadingState)
            return LoadingView();
          else if (state is SearchSuccessState) {
            if (index == 0)
              return _schoolScheduleWidget(state);
            else
              return _personalScheduleWidget(state);
          } else {
            return SizedBox();
          }
        },
        itemCount: 2,
      ),
    );
  }

  _schoolScheduleWidget(SearchState state) {
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
            child: schoolSchedulesOfDay.length != 0
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
                  Text(
                    schedule.address.contains('null')
                        ? 'No Data'
                        : '${schedule.address}',
                    style: TextStyle(
                        fontSize: ScUtil.getInstance().setSp(32),
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

  Widget _personalScheduleWidget(SearchState state) {
    List<PersonalSchedule> personalSchedulesOfDay =
        state.personalSchedulesOfDay;
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
                      return _personalScheduleElementWidget(schedule);
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

  _btnSearchOnPress(BuildContext context) async {
    DateTime selectDay = await showRoundedDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
      borderRadius: 20,
      fontFamily: 'MR',
      imageHeader: AssetImage("assets/img/calendar_header.jpg"),
    );
    BlocProvider.of<SearchBloc>(context)..add(SearchButtonOnPress(selectDay));
  }
}
