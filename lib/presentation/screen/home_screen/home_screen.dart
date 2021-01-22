import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/common/assets_constance.dart';
import 'package:schedule/common/router_list.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/schedule-widget.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_event.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_state.dart';
import 'package:schedule/presentation/screen/home_screen/home_screen_constance.dart';
import 'package:schedule/presentation/screen/home_screen/widgets/AccountWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  double screenWidth, screenHeight;

  AnimationController _controller;
  final Duration duration =
      const Duration(milliseconds: HomeScreenConstance.animationDuration);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
            milliseconds: HomeScreenConstance.animationDuration));
    BlocProvider.of<HomeBloc>(context)
        .add(HomeInitEvent(animationController: _controller));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = ScreenUtil().screenHeight;
    screenWidth = ScreenUtil().screenWidth;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (BuildContext context, state) {
        if (state is AddTodoState) {
          Navigator.pushNamed(context, RouterList.todo);
        }
      },
      builder: (BuildContext context, state) {
        if (state is HomeInitialState) {
          return body(state);
        }
        return Container();
      },
    );
  }

  Widget body(HomeState state) {
    return WillPopScope(
      onWillPop: () async {
        if (!state.animationEntity.isCollapsed) {
          BlocProvider.of<HomeBloc>(context)
              .add(SwitchDrawerEvent(isCollapsed: true));
          return false;
        } else
          return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            menu(context),
            AnimatedPositioned(
                left: state.animationEntity.isCollapsed ? 0 : 0.6 * screenWidth,
                right:
                    state.animationEntity.isCollapsed ? 0 : -0.2 * screenWidth,
                top: state.animationEntity.isCollapsed ? 0 : screenHeight * 0.1,
                bottom:
                    state.animationEntity.isCollapsed ? 0 : screenHeight * 0.1,
                duration: duration,
                curve: Curves.fastOutSlowIn,
                child: dashboard(state: state, context: context)),
          ],
        ),
      ),
    );
  }

  Widget menu(context) {
    return SafeArea(
      child: Container(
        color: ThemeColor.menuBackgroundColor,
        padding: const EdgeInsets.only(left: 0.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
              widthFactor: 0.6,
              heightFactor: 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AccountWidget(),
                  ),
                  Divider(
                    thickness: 1,
                    color: ThemeColor.dividerColor,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(AssetsConstance.scheduleIcon,
                            color: ThemeColor.secondColor),
                        title: Text(HomeScreenConstance.scheduleTitle,

                            ///todo
                            style: ThemeText.menuItemTextStyle),
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(SwitchDrawerEvent());
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading:
                            Icon(AssetsConstance.todoIcon, color: Colors.white),
                        title: Text(HomeScreenConstance.todoTitle,
                            style: ThemeText.menuItemTextStyle),
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(AddTodoEvent());
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      ListTile(
                        leading:
                            Icon(AssetsConstance.logoutIcon, color: Colors.white),
                        title: Text(HomeScreenConstance.logoutTitle,
                            style: ThemeText.menuItemTextStyle),
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(AddTodoEvent());
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget dashboard({HomeState state, context}) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.all(
            Radius.circular(state.animationEntity.borderRadius)),
        type: MaterialType.card,
        animationDuration: duration,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        child: GestureDetector(
          onTap: () {
            if (!state.animationEntity.isCollapsed) {
              BlocProvider.of<HomeBloc>(context).add(UserTapEvent());
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(
                Radius.circular(state.animationEntity.borderRadius)),
            child: Scaffold(
              body: Container(
                child: Stack(
                  children: [
                    ScheduleWidget(
                      drawerController: _controller,
                    ),
                    (state.animationEntity.isCollapsed)
                        ? SizedBox()
                        : Container(
                            color: Colors.transparent,
                            width: ScreenUtil().screenWidth,
                            height: ScreenUtil().screenHeight,
                          ),
                  ],
                ),
              ), //CalendarTabView(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouterList.todo);
                },
                child: Icon(Icons.add),
                backgroundColor: ThemeColor.addTodoButtonColor
                    .withOpacity(state.animationEntity.addTodoButtonOpacity),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
