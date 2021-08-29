import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/common/utils/convert.dart';
import 'package:schedule/domain/entities/personal_schedule_entities.dart';
import 'package:schedule/domain/entities/school_schedule_entities.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  Map<DateTime, List<SchoolSchedule>>? _schedulesSchoolMap =
      Map<DateTime, List<SchoolSchedule>>();
  Map<DateTime, List<PersonalScheduleEntities>>? _schedulesPersonalMap =
      Map<DateTime, List<PersonalScheduleEntities>>();

  ScheduleBloc() : super(UpdateScheduleDayInitState());

  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    // TODO: implement mapEventToState

    if (event is GetScheduleDayEvent) {
      yield UpdateScheduleDayLoadingState();
      _schedulesSchoolMap = event.allSchedulesSchoolMap;
      _schedulesPersonalMap = event.allSchedulePersonalMap;

      yield UpdateScheduleDaySuccessState(
          _schedulesSchoolMap![Convert.dateConvert(event.selectDay!)],
          _schedulesPersonalMap![Convert.dateConvert(event.selectDay!)],
          event.selectDay!);
    }
  }
}
