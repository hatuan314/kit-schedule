import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:schedule/common/themes/theme_color.dart';
import 'package:schedule/common/themes/theme_text.dart';
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
          backgroundColor:ThemeColor.secondColor,
          body: _currentTab,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(color:ThemeColor.secondColor, boxShadow: [
              BoxShadow(blurRadius: 20, color: ThemeColor.primaryColor.withOpacity(.1))
            ]),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: Row(

    children: [

    Expanded(
    flex: 1,
    child: navBarItem(context, 0, Icons.date_range ,state)),

    Expanded(
    flex: 1,child: navBarItem(context, 1,  Icons.search,state)),

    Expanded(
    flex: 1,child: navBarItem(context, 2, Icons.content_paste,state)),

    Expanded(
    flex: 1,child: navBarItem(context, 3, Icons.person,state)),

    ],
    ),
    ),
    ),
    ));
    }));
  }
  Widget navBarItem(BuildContext context,int index, IconData icon, HomeState state)
  {
    return  GestureDetector(
        onTap: (){ BlocProvider.of<HomeBloc>(context)
          ..add(OnTabChangeEvent(index));
        },
        child:
        Container(
          height: 50,
          child: Icon(icon, color: state.selectIndex==index?getColor(index): ThemeColor.primaryColor,),
        )

    );
  }
  Color getColor(int index) {
    switch (index) {
      case 0:
        return ThemeColor.scheduleType;
      case 1:
        return ThemeColor.searchType;
      case 2:
        return ThemeColor.fourthColor;
      case 3:
        return ThemeColor.searchType;

    }
    return ThemeColor.fourthColor;
  }

  void _warningSignOutDialog(BuildContext context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScUtil.getInstance()!.setHeight(20)),
          child: RichText(
            text: TextSpan(
                text: 'Do you want ',
                style:   ThemeText.titleStyle.copyWith( color: ThemeColor.thirdColor, ),
                children: [
                  TextSpan(
                      text: 'Sign Out ',
                      style:  ThemeText.titleStyle.copyWith( color: ThemeColor.errorColor, ),),
                  TextSpan(
                      text: '?',
                      style:
                      ThemeText.titleStyle.copyWith( color: ThemeColor.thirdColor,fontWeight: FontWeight.normal ), ),
                ]),
          ),
        ),
        btnOk: RaisedButton(
          color: ThemeColor.fourthColor,
          onPressed: () => _bntOkDialogOnPress(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 5,
          child: Container(
            alignment: Alignment.center,
            child: Text('Yes (Y)',
                style:ThemeText.titleStyle.copyWith( color: ThemeColor.secondColor,fontWeight: FontWeight.bold ),
                 ),
          ),
        ),
        btnCancel: RaisedButton(
          color: ThemeColor.errorColor,
          onPressed: () => _btnCancelDialogOnPress(context),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 5,
          child: Container(
            alignment: Alignment.center,
            child: Text('No (N)',
                style:ThemeText.titleStyle.copyWith( color: ThemeColor.secondColor,fontWeight: FontWeight.bold )
             ),
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
              vertical: ScUtil.getInstance()!.setHeight(20)),
          child: RichText(
            text: TextSpan(
                text: 'Can\'t ',
                style:  ThemeText.titleStyle.copyWith( color: ThemeColor.thirdColor,fontWeight: FontWeight.normal) ,
                children: [
                  TextSpan(
                      text: 'Sign Out ',
                      style:  ThemeText.titleStyle.copyWith( color: ThemeColor.errorColor,  fontSize: ScUtil.getInstance()!.setSp(36),)
                      ),
                  TextSpan(
                      text: 'now. Please, try again.',
                      style:  ThemeText.titleStyle.copyWith( color: ThemeColor.thirdColor,  fontSize: ScUtil.getInstance()!.setSp(36)),
                  )
                ]),
          ),
        ));
  }
}