import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';

import 'package:schedule/presentation/bloc/snackbar_bloc/bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_type.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/bloc/register_state.dart';
import 'package:schedule/service/services.dart';
import 'package:device_calendar/device_calendar.dart';

part 'register_event.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  ShareService _shareService = ShareService();
  final SnackbarBloc snackbarBloc;
  final ScheduleUseCase scheduleUseCase;
  final PersonalUseCase personalUseCase;




  RegisterBloc(
      {required this.snackbarBloc,
      required this.personalUseCase,
      required this.scheduleUseCase})
      : super(RegisterInitState());

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
      bool isSaveUsername = await ShareService().setUsername(event.account);
      try {
        var data =
            await scheduleUseCase.fetchScheduleSchoolData(account, password);
        if (data!.isEmpty) {
          snackbarBloc.add(ShowSnackbar(
              title: '${SnackBarTitle.NoData}', type: SnackBarType.error));
          yield RegisterNoDataState();
        } else {
          List<PersonalScheduleEntities> list =
              await personalUseCase.fetchPersonalSchoolDataFirebase(account);
          await _savePersonalSchool(list, state);
          await _saveScheduleSchool(data, state);
          await _shareService.setIsSaveData(true);
          await _shareService.setHasNoti(false);

          yield RegisterSuccessState();
        }
      } catch (e) {
        snackbarBloc.add(
            ShowSnackbar(title: '${SnackBarTitle.ConnectionFailed}', type: SnackBarType.error));
        yield RegisterFailureState(e.toString());
      }
    }
  }

  _savePersonalSchool(
      List<PersonalScheduleEntities> personal, RegisterState state) async {
    try {
      if (personal.isNotEmpty) {
        personal.forEach((element) async {
          PersonalScheduleEntities personalScheduleEntities=element;
          personalScheduleEntities.isSynchronized=true;
          await personalUseCase.insertPersonalSchedule(personalScheduleEntities);
        });
      }
    } catch (e) {
      debugPrint('RegisterBloc - saveSchoolSchedule - error: {$e}');
    }
  }

  _saveScheduleSchool(Map scheduleDataMap, RegisterState state) async {
    List dates = scheduleDataMap.keys.toList();
    List<SchoolSchedule> schoolSchedule = [];
    try {
      dates.forEach((date) {
        if (scheduleDataMap[date] != null || scheduleDataMap[date].length > 0)
          scheduleDataMap[date].forEach((scheduleJson) async {
            schoolSchedule.add(SchoolSchedule.fromJsonApi(scheduleJson, date));
          });
      });
      await scheduleUseCase.insertSchoolScheduleLocal(schoolSchedule);
    } catch (e) {
      debugPrint('RegisterBloc - saveSchoolSchedule - error: {$e}');
    }
  }


}
