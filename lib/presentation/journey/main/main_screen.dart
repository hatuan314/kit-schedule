import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/home/home_bloc.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_screen.dart';
import 'package:schedule/presentation/journey/home/calendar_tab_constants.dart';
import 'package:schedule/presentation/journey/search/search_screen.dart';
import 'package:schedule/presentation/journey/todo/create_todo_tab_screen.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';

import 'main_constants.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocListener<HomeBloc, HomeState>(listener: (context, state) {
      if (state is HomeOnChangeTabState) if (state.selectIndex == 3)
        _warningSignOutDialog(context);
      if (state is SignOutFailureState) _errorSignOutDialog(context);
    }, child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      Widget _currentTab = CalendarTabScreen();
      if (state.selectIndex == 2)
        _currentTab = CreateTodoTabView();
      else if (state.selectIndex == 1)
        _currentTab = SearchScreen();
      else
        _currentTab = CalendarTabScreen();
      return Scaffold(
          backgroundColor: AppColor.secondColor,
          body: _currentTab,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                color: AppColor.secondColor,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      color: AppColor.primaryColor.withOpacity(.1))
                ]),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: MainScreenConstants.paddingHorizontal,
                        vertical: MainScreenConstants.paddingVertical),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: navBarItem(context, 0, Icons.date_range, state)),
                    Expanded(
                        flex: 1,
                        child: navBarItem(context, 1, Icons.search, state)),
                    Expanded(
                        flex: 1,
                        child:
                            navBarItem(context, 2, Icons.content_paste, state)),
                    Expanded(
                        flex: 1,
                        child: navBarItem(context, 3, Icons.person, state)),
                  ],
                ),
              ),
            ),
          ));
    }));
  }

  Widget navBarItem(
      BuildContext context, int index, IconData icon, HomeState state) {
    return GestureDetector(
        onTap: () {
          BlocProvider.of<HomeBloc>(context)..add(OnTabChangeEvent(index));
        },
        child: Container(
          height:  MainScreenConstants.navBarHeight,
          child: Icon(
            icon,
            color: state.selectIndex == index
                ? getColor(index)
                : AppColor.primaryColor,
          ),
        ));
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return AppColor.scheduleType;
      case 1:
        return AppColor.searchType;
      case 2:
        return AppColor.fourthColor;
      case 3:
        return AppColor.searchType;
    }
    return AppColor.fourthColor;
  }

  void _warningSignOutDialog(BuildContext context) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        body: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: MainScreenConstants.dialogPaddingVertical),
          child: RichText(
            text: TextSpan(
                text: MainScreenConstants.confirmSignOutTxt,
                style: ThemeText.titleStyle.copyWith(
                  color: AppColor.thirdColor,
                ),
                children: [
                  TextSpan(
                    text: MainScreenConstants.signOutTxt,
                    style: ThemeText.titleStyle.copyWith(
                      color: AppColor.errorColor,
                    ),
                  ),
                  TextSpan(
                    text: MainScreenConstants.punctuationMarkTxt,
                    style: ThemeText.titleStyle.copyWith(
                        color: AppColor.thirdColor,
                        fontWeight: FontWeight.normal),
                  ),
                ]),
          ),
        ),
        btnOk: GestureDetector(
          onTap: () => _bntOkDialogOnPress(context),
          child: Container(
            margin: const EdgeInsets.only(bottom: MainScreenConstants.containerMarginBottom),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.fourthColor,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(
                    0,
                    3,
                  ),
                )
              ],
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: MainScreenConstants.paddingVertical,
                horizontal: MainScreenConstants.paddingHorizontal
              ),
              child: Text(
                MainScreenConstants.yesTxt,
                style: ThemeText.buttonLabelStyle.copyWith(
                    color: AppColor.secondColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        btnCancel: GestureDetector(
          onTap: () => _btnCancelDialogOnPress(context),
          child: Container(
            margin: const EdgeInsets.only(bottom: MainScreenConstants.containerMarginBottom),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.errorColor,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(
                    0,
                    3,
                  ),
                )
              ],
            ),
            alignment: Alignment.center,
            child: Padding(
              padding:const EdgeInsets.symmetric(
                  vertical: MainScreenConstants.paddingVertical,
                  horizontal: MainScreenConstants.paddingHorizontal
              ),
              child: Text(MainScreenConstants.noTxt,
                  style: ThemeText.buttonLabelStyle.copyWith(
                      color: AppColor.secondColor,
                      fontWeight: FontWeight.bold)),
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
              vertical: MainScreenConstants.errorDialogPaddingVertical),
          child: RichText(
            text: TextSpan(
                text: MainScreenConstants.errorSignOutTxt1,
                style: ThemeText.titleStyle.copyWith(
                    color: AppColor.thirdColor,
                    fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                      text: MainScreenConstants.signOutTxt,
                      style: ThemeText.titleStyle.copyWith(
                        color: AppColor.errorColor,
                      )),
                  TextSpan(
                    text: MainScreenConstants.errorSignOutTxt2,
                    style: ThemeText.titleStyle.copyWith(
                        color: AppColor.thirdColor, ),
                  )
                ]),
          ),
        ));
  }
}
