import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        create: (context) =>
        ProfileBloc()
          ..add(GetUserNameEvent()),
        child: BlocBuilder<ProfileBloc, ProfileState>(
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
                              margin: EdgeInsets.only(
                                   top: ProfileConstants.margin),
                              padding: EdgeInsets.all(ProfileConstants.iconPadding),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle),
                              child: Text(
                           profileState.username.substring(0, 2),
                                style: ThemeText.headerStyle2.copyWith(fontSize: 35),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: ProfileConstants.paddingVertical),
                              child: Text(
                                profileState.username,
                                textAlign: TextAlign.center,
                                style:ThemeText.headerStyle2,
                              ),
                            )
                          ],
                        ),
                      ),
                      _buildListTile(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context).add(
                                OnTabChangeEvent(1));
                          },
                          title: 'My Scores'),
                      _buildListTile(
                          onTap: () {
                            StoreRedirect.redirect(
                              androidAppId: 'kma.hatuan314.schedule'
                            );
                          },
                          title: 'Rate Me'),
                      _buildListTile(
                          onTap: () {
                            BlocProvider.of<HomeBloc>(context).add(
                                OnTabChangeEvent(4));
                          },
                          title: 'Log Out'),

                    ],
                  ),
                ),
              );
            }));
  }


  Widget _buildListTile({required Function()? onTap, required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ProfileConstants.listTilePadding),
        color:  AppColor.secondColor,
        child: Text(
            title,
            style: ThemeText.titleStyle2.copyWith(color:  AppColor.signInColor)
        ),
      ),
    );
  }
}
