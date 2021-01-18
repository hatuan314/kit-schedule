import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/src/service/services.dart';

part './home_event.dart';
part './home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  RepositoryOffline _repositoryOffline = RepositoryOffline();
  @override
  // TODO: implement initialState
  HomeState get initialState => HomeInitialState(0);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is OnTabDrawerEvent) {
      yield DrawerChangeState(event.selectIndex);
    } else if (event is SignOutOnPressEvent) {
      ShareService shareService = ShareService();
      try {
        await _repositoryOffline.deleteAllSchoolSchedulesRepo();
        await shareService.setIsSaveData(false);
        yield SignOutSuccessState(0);
      } catch (e) {
        debugPrint('HomeBloc - mapEventToState - Error: {$e}');
        yield SignOutFailureState(0);
      }
    }
    else if(event is AddTodoEvent)
      {

      }
  }
}
