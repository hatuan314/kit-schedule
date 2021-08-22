import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/service/services.dart';

part './home_event.dart';
part './home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  RepositoryOffline _repositoryOffline = RepositoryOffline();

  HomeBloc() : super(HomeInitialState(0));
    @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is OnTabChangeEvent) {
      yield HomeOnChangeTabState(event.selectIndex);
    } else if (event is SignOutOnPressEvent) {
      ShareService shareService = ShareService();
      try {
        await _repositoryOffline.deleteAllSchoolSchedulesRepo();
        await shareService.setUsername('');
        await shareService.setIsSaveData(false);
        yield SignOutSuccessState(0);
      } catch (e) {
        debugPrint('HomeBloc - mapEventToState - Error: {$e}');
        yield SignOutFailureState(0);
      }
    }
  }
}
