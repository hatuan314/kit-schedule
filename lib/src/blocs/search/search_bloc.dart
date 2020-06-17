import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schedule/src/models/model.dart';
import 'package:schedule/src/service/services.dart';
import 'package:schedule/src/utils/utils.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  RepositoryOffline _repositoryOffline = RepositoryOffline();

  List<SchoolSchedule> _schoolSchedulesOfDay = List<SchoolSchedule>();
  List<PersonalSchedule> _personalSchedulesOfDay = List<PersonalSchedule>();
  DateTime _selectDay = DateTime.now();

  @override
  // TODO: implement initialState
  SearchState get initialState => SearchWaitingState(
      DateFormat('dd/MM/yyyy').format(this._selectDay),
      _schoolSchedulesOfDay,
      _personalSchedulesOfDay);

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SearchButtonOnPress) {
      yield SearchLoadingState(DateFormat('dd/MM/yyyy').format(this._selectDay),
          _schoolSchedulesOfDay, _personalSchedulesOfDay);
      try {
        _selectDay = Convert.dateConvert(event.selectDay);
        yield* _mapGetSchoolSchedulesData();
        yield* _mapGetPersonalScheduleData();
        debugPrint('mapEventToState - date: ${DateFormat('dd/MM/yyyy').format(this._selectDay)}');
        yield SearchSuccessState(DateFormat('dd/MM/yyyy').format(this._selectDay),
            _schoolSchedulesOfDay, _personalSchedulesOfDay);
      } catch (e) {
        yield SearchFailure(
            e.toString(),
            DateFormat('dd/MM/yyyy').format(this._selectDay),
            _schoolSchedulesOfDay,
            _personalSchedulesOfDay);
      }
    }
  }

  Stream<SearchState> _mapGetSchoolSchedulesData() async* {
    try {
      var result = await _repositoryOffline.fetchAllSchoolScheduleOfDateRepo(
          this._selectDay.millisecondsSinceEpoch.toString());
      if (result == null || result.length == 0)
        _schoolSchedulesOfDay = [];
      else
        _schoolSchedulesOfDay = result;
    } catch (e) {
      debugPrint('SearchBloc - mapGetSchoolSchedulesData - Errror: {$e}');
    }
  }

  Stream<SearchState> _mapGetPersonalScheduleData() async* {
    try {
      var result = await _repositoryOffline.fetchAllPersonalScheduleOfDateRepo(
          this._selectDay.millisecondsSinceEpoch.toString());
      if (result == null || result.length == 0)
        _personalSchedulesOfDay = [];
      else
        _personalSchedulesOfDay = result;
    } catch (e) {
      debugPrint('SearchBloc - mapGetPersonalSchedulesData - Errror: {$e}');
    }
  }
}
