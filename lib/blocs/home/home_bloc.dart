import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/blocs/blocs.dart';
import 'package:schedule/common/injector/injector.dart';
import 'package:schedule/domain/usecase/personal_usecase.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';
import 'package:schedule/service/services.dart';

part './home_event.dart';
part './home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
final ScheduleUseCase scheduleUS;
final PersonalUseCase personalUS;
  HomeBloc({required this.personalUS,required this.scheduleUS}) : super(HomeInitialState(0));
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is OnTabChangeEvent) {
      yield HomeOnChangeTabState(event.selectIndex);
    } else if (event is SignOutOnPressEvent) {
      ShareService shareService = ShareService();
      try {
        await scheduleUS.deleteAllSchoolSchedulesLocal();
        await personalUS.deleteAllSchoolPersonal();
        await shareService.setUsername('');
        await shareService.setIsSaveData(false);
        Injector.getIt.resetLazySingleton<CalendarBloc>();
        yield SignOutSuccessState(0);
      } catch (e) {
        debugPrint('HomeBloc - mapEventToState - Error: {$e}');
        yield SignOutFailureState(0);
      }
    }
  }
}
