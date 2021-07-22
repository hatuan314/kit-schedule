import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/models/model.dart';
import 'package:schedule/service/services.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RepositoryOnline _online = RepositoryOnline();
  RepositoryOffline _offline = RepositoryOffline();
  ShareService _shareService = ShareService();

  RegisterBloc() : super(RegisterInitState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ShowPasswordOnPress) {
      if (event.isShow) {
        yield RegisterShowPasswordState(true);
      } else {
        yield RegisterShowPasswordState(false);
      }
    } else if (event is SignInOnPressEvent) {
      yield RegisterLoadingState();
      String account = event.account;
      String password = md5.convert(utf8.encode(event.password)).toString();
      try {
        var dataJson =
            await _online.fetchScheduleSchoolDataRepo(account, password);
        if (dataJson == '') {
          yield RegisterNoDataState();
        } else {
          Map data = json.decode(dataJson);
          await _saveScheduleSchool(data, state);
          await _shareService.setIsSaveData(true);
          yield RegisterSuccessState();
        }
      } catch (e) {
        yield RegisterFailureState(e.toString());
      }
    }
  }

  _saveScheduleSchool(Map scheduleDataMap, RegisterState state) async {
    List dates = scheduleDataMap.keys.toList();
    try {
      dates.forEach((date) {
        if (scheduleDataMap[date] != null || scheduleDataMap[date].length > 0)
          scheduleDataMap[date].forEach((scheduleJson) async {
            SchoolSchedule schoolSchedule =
                SchoolSchedule.fromJsonApi(scheduleJson, date);
            await _offline.addScheduleLessonRepo(schoolSchedule);
          });
      });
    } catch (e) {
      debugPrint('RegisterBloc - saveSchoolSchedule - error: {$e}');
    }
  }
}
