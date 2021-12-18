import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:schedule/blocs/calendar/calendar_bloc.dart';
import 'package:schedule/blocs/home/home_bloc.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/presentation/%20language_select/%20language_select.dart';
import 'package:schedule/presentation/journey/main/main_item.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_bloc.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_event.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_state.dart';
import 'package:schedule/presentation/journey/profile/profile_constants.dart';
import 'package:schedule/presentation/journey/scores/bloc/scores_bloc.dart';
import 'package:schedule/presentation/journey/scores/bloc/scores_event.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:schedule/presentation/widget/warning_dialog/open_setting_dialog.dart';
import 'package:schedule/presentation/widget/warning_dialog/warning_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, profileState) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.secondColor,
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: ProfileConstants.margin),
                        padding: EdgeInsets.all(ProfileConstants.iconPadding),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.person,
                          color: AppColor.personalScheduleColor2,
                          size: ProfileConstants.iconSize,
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: ProfileConstants.paddingVertical),
                      child: profileState.username.isNotEmpty
                          ? Text(
                              profileState.username,
                              textAlign: TextAlign.center,
                              style: ThemeText.headerStyle2,
                            )
                          : SizedBox(),
                    )
                  ],
                ),
              ),
              _buildListTile(
                  icon: Icons.score_outlined,
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(OnTabChangeEvent(MainItem.ScoresScreenItem));
                  },
                  title: AppLocalizations.of(context)!.myScores),
              _buildListTile(
                  icon: Icons.language,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (dialogContext) =>
                            settingDialog(context, true, profileState));
                  },
                  title: AppLocalizations.of(context)!.language),
              _buildListTile(
                  icon: Icons.notifications_none,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (dialogContext) =>
                            settingDialog(context, false, profileState));
                  },
                  title: AppLocalizations.of(context)!.notification),
              _buildListTile(
                  icon: Icons.info_outline,
                  onTap: _launchURL,
                  title: AppLocalizations.of(context)!.aboutUs),
              _buildListTile(
                  icon: Icons.star_rate_outlined,
                  onTap: () {
                    StoreRedirect.redirect(
                      androidAppId: ProfileConstants.androidAppId,
                    );
                  },
                  title: AppLocalizations.of(context)!.rateMe),
              _buildListTile(
                  icon: profileState.isLogIn ? Icons.logout : Icons.login,
                  onTap: () {
                    actionLogIn(context, profileState.isLogIn);
                  },
                  title: profileState.isLogIn
                      ? AppLocalizations.of(context)!.logOut
                      : AppLocalizations.of(context)!.login),
            ],
          ),
        ),
      );
    }
        //)
        );
  }

  void actionLogIn(BuildContext context, bool isLogIn) {
    if (isLogIn) {
      warningDialog(
          context: context,
          isSynch: true,
          btnOk: _bntOkDialogOnPress,
          btnCancel: _btnCancelDialogOnPress);
    } else {
      Navigator.pushNamed(context, '/sign-in').then((value) {
        if (value is bool && value) {
          BlocProvider.of<HomeBloc>(context)
              .add(OnTabChangeEvent(MainItem.CalendarTabScreenItem));
          BlocProvider.of<CalendarBloc>(context).add(GetAllScheduleDataEvent());
          BlocProvider.of<TodoBloc>(context).add(GetUserNameEvent());
          BlocProvider.of<ProfileBloc>(context)
              .add(GetUserNameInProfileEvent());
          BlocProvider.of<ScoresBloc>(context)..add(InitEvent())..add(LoadScoresEvent());
        }
      });
    }
  }

  _btnCancelDialogOnPress(BuildContext context) {
    Navigator.of(context).pop();
  }

  _bntOkDialogOnPress(BuildContext context) {
    BlocProvider.of<HomeBloc>(context)..add(SignOutOnPressEvent());
    Navigator.of(context).pop();
  }

  bool isEnglish(String isEng) {
    if (isEng == 'vi') {
      return false;
    }
    return true;
  }

  Widget _buildListTile(
      {required Function()? onTap,
      required String title,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ProfileConstants.listTilePadding),
        color: AppColor.secondColor,
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.signInColor,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(title,
                style: ThemeText.buttonStyle
                    .copyWith(color: AppColor.signInColor)),
          ],
        ),
      ),
    );
  }

  Widget settingDialog(
      BuildContext context, bool isLanguageDialog, ProfileState profileState) {
    return SimpleDialog(
        contentPadding: EdgeInsets.only(
          bottom: ProfileConstants.listTilePadding,
          top: ProfileConstants.listTilePadding,
        ),
        title: Text(
            isLanguageDialog
                ? AppLocalizations.of(context)!.language
                : AppLocalizations.of(context)!.notification,
            style: ThemeText.titleStyle
                .copyWith(color: AppColor.personalScheduleColor2)),
        children: [
          _dialogItem(
              title: isLanguageDialog
                  ? ProfileConstants.englishTxt
                  : AppLocalizations.of(context)!.turnOn,
              context: context,
              isLanguageDialog: isLanguageDialog,
              onTap: isLanguageDialog
                  ? () {
                      Injector.getIt<LanguageSelect>().changeLanguage(true);
                    }
                  : !profileState.hasNoti
                      ? () async {
                          if (await Permission.calendar.isDenied) {
                            Navigator.pop(context);
                            openSettingDiaLog(
                                context: context,
                                );
                            return;
                          } else {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(TurnOnNotificationEvent());
                            Navigator.pop(context);
                            BlocProvider.of<ProfileBloc>(context)
                                .add(GetUserNameInProfileEvent());
                          }
                        }
                      : () {},
              visible: isLanguageDialog
                  ? isEnglish(AppLocalizations.of(context)!.localeName)
                  : profileState.hasNoti),
          _dialogItem(
              title: isLanguageDialog
                  ? ProfileConstants.vietnameseTxt
                  : AppLocalizations.of(context)!.turnOff,
              context: context,
              isLanguageDialog: isLanguageDialog,
              onTap: isLanguageDialog
                  ? () {
                      Injector.getIt<LanguageSelect>().changeLanguage(false);
                    }
                  : profileState.hasNoti
                      ? () {
                          BlocProvider.of<ProfileBloc>(context)
                              .add(TurnOffNotificationEvent());
                          Navigator.pop(context);
                          BlocProvider.of<ProfileBloc>(context)
                              .add(GetUserNameInProfileEvent());
                        }
                      : () {},
              visible: isLanguageDialog
                  ? !isEnglish(AppLocalizations.of(context)!.localeName)
                  : !profileState.hasNoti),
        ]);
  }

  Widget _dialogItem(
      {required String title,
      required BuildContext context,
      required bool isLanguageDialog,
      required Function()? onTap,
      required bool visible}) {
    return GestureDetector(
        onTap: onTap,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.all(ProfileConstants.listTilePadding),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: ThemeText.buttonStyle
                          .copyWith(color: AppColor.personalScheduleColor2),
                    ),
                  ),
                ),
                Visibility(
                    visible: visible,
                    child: Icon(
                      Icons.check,
                      color: AppColor.personalScheduleColor2,
                    ))
              ],
            ),
          ),
          Container(
              height: 0.2,
              width: MediaQuery.of(context).size.width - 50,
              color: Colors.grey),
        ]));
  }

  _launchURL() async {
    const url = 'https://www.facebook.com/kitclubKMA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      log('Could not launch $url');
    }
  }
}
