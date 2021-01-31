import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/data/data_sources/share_service.dart';
import 'package:schedule/domain/entities/animation_entities.dart';
import 'package:schedule/domain/use_cases/HomeUseCase.dart';
import 'package:schedule/presentation/journey/home_screen/home_bloc/home_event.dart';
import 'package:schedule/presentation/journey/home_screen/home_bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUseCase;
  AnimationEntity animationEntity;

  HomeBloc({@required this.homeUseCase});

  @override
  HomeState get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is HomeInitEvent) {
      yield* mapHomeInitEventToState(event);
    } else if (event is UserTapEvent) {
      yield* mapUserTapEventToState();
    }else if (event is AddTodoEvent) {
      yield* mapAddTodoEventToState();
    } else if (event is OpenDrawerEvent) {
      yield* mapOpenDrawerEventToState();
    } else if (event is SwitchDrawerEvent) {
      yield* mapSwitchDrawerEventToState();
    } else if (event is SignOutOnPressEvent) {
      ShareService shareService = ShareService();
      try {
        //await _repositoryOffline.deleteAllSchoolSchedulesRepo();
        await shareService.setIsSaveData(false);
        yield SignOutSuccessState();
      } catch (e) {
        debugPrint('HomeBloc - mapEventToState - Error: {$e}');
        yield SignOutFailureState();
      }
    }
  }

  Stream<HomeState> mapHomeInitEventToState(HomeInitEvent event) async* {
    animationEntity =
        homeUseCase.init(animationEntity: animationEntity, event: event);
    yield HomeInitialState(animationEntity: animationEntity);
  }


  Stream<HomeState> mapAddTodoEventToState() async* {
    yield SwitchDrawerState();
    yield AddTodoState();
    yield HomeInitialState();
  }

  Stream<HomeState>mapSwitchDrawerEventToState() async* {
    yield SwitchDrawerState();
    yield HomeInitialState();
  }
  Stream<HomeState>mapOpenDrawerEventToState() async* {
    yield OpenDrawerState();
    yield HomeInitialState();
  }

  Stream<HomeState>mapUserTapEventToState() async*{
    yield UserTapState();
    yield HomeInitialState();
  }
}

