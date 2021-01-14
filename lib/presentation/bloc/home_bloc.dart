import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/presentation/bloc/home_event.dart';
import 'package:schedule/presentation/bloc/home_state.dart';
import 'package:schedule/src/service/share_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {


  HomeBloc();

  @override
  HomeState get initialState => HomeInitialState(0);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is OnTabChangeEvent) {
      yield HomeOnChangeTabState(event.selectIndex);
    } else if (event is SignOutOnPressEvent) {
      ShareService shareService = ShareService();
      try {
        //await _repositoryOffline.deleteAllSchoolSchedulesRepo();
        await shareService.setIsSaveData(false);
        yield SignOutSuccessState(0);
      } catch (e) {
        debugPrint('HomeBloc - mapEventToState - Error: {$e}');
        yield SignOutFailureState(0);
      }
    }
  }
  //
  // Stream<HomeState> SignOutOnPressEvent() async* {
  //   yield HomeLoadingState();
  //
  //   yield HomeInitialState();
  // }


}
