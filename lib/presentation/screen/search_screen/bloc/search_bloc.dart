import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/entities/personal_schedule.dart';
import 'package:schedule/domain/use_cases/search_use_case.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_event.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent,SearchState>{
  final SearchUseCase useCase;

  SearchBloc({@required this.useCase});

  @override
  SearchState get initialState => SearchLoadingState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchInitEvent){
      yield* _mapSearchInitEventToState();
    }else if (event is SearchScheduleEvent){
      yield* _mapSearchScheduleEventToState(event);
    }
  }

  Stream<SearchState>_mapSearchInitEventToState() async*{
    yield SearchLoadingState();
    List<String> historySearch = List<String>();
    historySearch.add('Lập Trình Mạng');
    historySearch.add('Phân Tích Thiết Kế Hệ Thống');
    historySearch.add('Tiếng Anh Chuyên Ngành');
    historySearch.add('Nguyên Lý Hệ Điều Hành');
    yield SearchInitState(searchHistory: historySearch);
  }

  Stream<SearchState>_mapSearchScheduleEventToState(SearchScheduleEvent event) async* {
    yield SearchLoadingState();
    List<PersonalSchedule> schedule = List<PersonalSchedule>();
    schedule.add(PersonalSchedule(title: "Test", note: "Normal Test", times: '18:00', date: '15/2/2021'));
    schedule.add(PersonalSchedule(title: 'Test 2', note: 'Normal Test 2', times: '5:00', date: '28/12/2020'));
    schedule.add(PersonalSchedule(title: "Test 3", note: 'Normal Test 3', times: '20:30', date: '30/1/2021'));
    yield SearchSuccessState(listSchedule: schedule);
  }

}