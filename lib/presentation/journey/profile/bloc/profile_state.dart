import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum appState { logIn, logOut }

extension appStateExtensin on appState {
  String getName(BuildContext context) {
    switch (this) {
      case appState.logIn:
        return AppLocalizations.of(context)!.login;
      case appState.logOut:
        return AppLocalizations.of(context)!.logOut;
    }
  }

  IconData getIcon() {
    switch (this) {
      case appState.logOut:
        return Icons.logout;
      case appState.logIn:
        return Icons.login;
    }
  }
}

class ProfileState extends Equatable {
  final String username;
  final bool hasNoti;
  final bool isLogIn;
  final bool? isEnglish;
  final bool? isAccountFeaturesEnabled;
  ProfileState({
    required this.username,
    required this.hasNoti,
    this.isEnglish,
    this.isLogIn = false,
    this.isAccountFeaturesEnabled = false,
  });

  ProfileState update({
    String? username,
    bool? hasNoti,
    bool? isEnglish,
    bool? isLogin,
    bool? isAccountFeaturesEnabled,
  }) =>
      ProfileState(
        isLogIn: isLogin ?? this.isLogIn,
        username: username ?? this.username,
        hasNoti: hasNoti ?? this.hasNoti,
        isEnglish: isEnglish ?? this.isEnglish,
        isAccountFeaturesEnabled:
            isAccountFeaturesEnabled ?? this.isAccountFeaturesEnabled,
      );

  @override
  // TODO: implement props
  List<Object?> get props =>
      [this.username, this.hasNoti, this.hasNoti, this.isLogIn];
}
