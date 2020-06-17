import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:schedule/src/blocs/home/home_bloc.dart';
import 'package:schedule/src/utils/multi_screen/flutter_screen_util.dart';

import 'tabs/tabs.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeOnChangeTabState) if (state.selectIndex == 3)
          _warningSignOutDialog(context);
        if (state is SignOutFailureState) _errorSignOutDialog(context);
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        Widget _currentTab = CalendarTabView();
        if (state.selectIndex == 2)
          _currentTab = CreateTodoTabView();
        else if (state.selectIndex == 1)
          _currentTab = SearchView();
        else
          _currentTab = CalendarTabView();
        return Scaffold(
          backgroundColor: Color(0xffFCFAF3),
          body: _currentTab,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Color(0xffFCFAF3), boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ]),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                    gap: 8,
                    activeColor: Color(0xffFCFAF3),
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: 800),
                    tabBackgroundColor: Colors.grey[800],
                    tabs: [
                      GButton(
                        icon: Icons.date_range,
                        backgroundColor: Colors.red,
                        textColor: Color(0xffFCFAF3),
                        iconActiveColor: Color(0xffFCFAF3),
                        iconColor: Colors.black,
                        text: 'Schedule',
                        textStyle: TextStyle(
                            color: Color(0xffFCFAF3),
                            fontFamily: 'MR',
                            fontWeight: FontWeight.w500),
                      ),
                      GButton(
                        icon: Icons.search,
                        backgroundColor: Colors.amber,
                        textColor: Color(0xffFCFAF3),
                        iconActiveColor: Color(0xffFCFAF3),
                        iconColor: Colors.black,
                        text: 'Search',
                        textStyle: TextStyle(
                            color: Color(0xffFCFAF3),
                            fontFamily: 'MR',
                            fontWeight: FontWeight.w500),
                      ),
                      GButton(
                        icon: Icons.content_paste,
                        backgroundColor: Colors.blue,
                        textColor: Color(0xffFCFAF3),
                        iconActiveColor: Color(0xffFCFAF3),
                        iconColor: Colors.black,
                        text: 'Create Todo',
                        textStyle: TextStyle(
                            color: Color(0xffFCFAF3),
                            fontFamily: 'MR',
                            fontWeight: FontWeight.w500),
                      ),
                      GButton(
                        icon: Icons.power_settings_new,
                        backgroundColor: Colors.red,
                        textColor: Color(0xffFCFAF3),
                        iconActiveColor: Color(0xffFCFAF3),
                        iconColor: Colors.black,
                        text: 'Sign out',
                        textStyle: TextStyle(
                            color: Color(0xffFCFAF3),
                            fontFamily: 'MR',
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                    selectedIndex:
                        state is HomeOnChangeTabState ? state.selectIndex : 0,
                    onTabChange: (index) => BlocProvider.of<HomeBloc>(context)
                      ..add(OnTabChangeEvent(index))),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _warningSignOutDialog(BuildContext context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScUtil.getInstance().setHeight(20)),
          child: RichText(
            text: TextSpan(
                text: 'Do you want ',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScUtil.getInstance().setSp(32),
                    fontFamily: 'MR',
                    fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                      text: 'Sign Out ',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: ScUtil.getInstance().setSp(32),
                          fontFamily: 'MR',
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: '?',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScUtil.getInstance().setSp(32),
                          fontFamily: 'MR',
                          fontWeight: FontWeight.normal)),
                ]),
          ),
        ),
        btnOk: RaisedButton(
          color: Colors.blue,
          onPressed: () => _bntOkDialogOnPress(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 5,
          child: Container(
            alignment: Alignment.center,
            child: Text('Yes (Y)',
                style: TextStyle(
                    color: Color(0xffFCFAF3),
                    fontSize: ScUtil.getInstance().setSp(32),
                    fontFamily: 'MR',
                    fontWeight: FontWeight.bold)),
          ),
        ),
        btnCancel: RaisedButton(
          color: Colors.red,
          onPressed: () => _btnCancelDialogOnPress(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 5,
          child: Container(
            alignment: Alignment.center,
            child: Text('No (N)',
                style: TextStyle(
                    color: Color(0xffFCFAF3),
                    fontSize: ScUtil.getInstance().setSp(32),
                    fontFamily: 'MR',
                    fontWeight: FontWeight.bold)),
          ),
        )).show();
  }

  _btnCancelDialogOnPress(BuildContext context) {
    BlocProvider.of<HomeBloc>(context)..add(OnTabChangeEvent(0));
    Navigator.of(context).pop();
  }

  _bntOkDialogOnPress(BuildContext context) {
    BlocProvider.of<HomeBloc>(context)..add(SignOutOnPressEvent());
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  void _errorSignOutDialog(BuildContext context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScUtil.getInstance().setHeight(20)),
          child: RichText(
            text: TextSpan(
                text: 'Can\'t ',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: ScUtil.getInstance().setSp(36),
                    fontFamily: 'MR',
                    fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                      text: 'Sign Out ',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: ScUtil.getInstance().setSp(36),
                          fontFamily: 'MR',
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: 'now. Please, try again.',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScUtil.getInstance().setSp(36),
                          fontFamily: 'MR',
                          fontWeight: FontWeight.normal)),
                ]),
          ),
        ));
  }
}
