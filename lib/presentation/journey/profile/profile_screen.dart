import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schedule/blocs/home/home_bloc.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_bloc.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_event.dart';
import 'package:schedule/presentation/journey/profile/bloc/profile_state.dart';
import 'package:schedule/presentation/journey/profile/profile_constants.dart';
import 'package:schedule/presentation/themes/theme_colors.dart';
import 'package:schedule/presentation/themes/theme_text.dart';
import 'package:store_redirect/store_redirect.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc()..add(GetUserNameEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, profileState) {
          log(profileState.username.length.toString());
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
                          decoration: BoxDecoration(color: Colors.blue.shade100, shape: BoxShape.circle),
                          child: Text(
                            profileState.username.length != 0 ? profileState.username.substring(0, 2) : '',
                            style: ThemeText.headerStyle2.copyWith(fontSize: 35),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: ProfileConstants.paddingVertical),
                          child: Text(
                            profileState.username,
                            textAlign: TextAlign.center,
                            style: ThemeText.headerStyle2,
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildListTile(
                      icon: Icons.score_outlined,
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context).add(OnTabChangeEvent(1));
                      },
                      title: 'My Scores'),
                  _buildListTile(
                      icon: Icons.star_rate_outlined,
                      onTap: () {
                        StoreRedirect.redirect(
                          androidAppId: ProfileConstants.androidAppId,
                        );
                      },
                      title: ProfileConstants.rateMeTxt),
                  _buildListTile(
                      icon: Icons.logout,
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context).add(OnTabChangeEvent(4));
                      },
                      title: ProfileConstants.logOutTxt),
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildListTile({required Function()? onTap, required String title, required IconData icon}) {
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
            Text(title, style: ThemeText.buttonStyle.copyWith(color: AppColor.signInColor)),
          ],
        ),
      ),
    );
  }
}
