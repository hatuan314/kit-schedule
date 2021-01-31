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
  HomeState get initialState => HomeLoadingState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeInitEvent) {
      yield* mapHomeInitEventToState(event);
    } else if (event is UserTapEvent) {
      yield* mapUserTapEventToState();
    }else if (event is AddTodoEvent) {
      yield* mapAddTodoEventToState();
    } else if (event is OpenDrawerEvent) {
      yield* mapOpenDrawerEventToState();
    } else if (event is SwitchDrawerEvent) {
      yield* mapSwitchDrawerEventToState(event);
    } else if (event is ScrollEvent) {
      yield* mapScrollEventToState();
    } else if (event is ScrollStopEvent) {
      yield* mapScrollStopEventToState();
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
    homeUseCase.switchDrawer(animationEntity: animationEntity);
    yield AddTodoState();
    yield HomeInitialState(animationEntity: animationEntity);
  }

  Stream<HomeState>mapSwitchDrawerEventToState(SwitchDrawerEvent event) async* {
    yield SwitchDrawerState();
    homeUseCase.switchDrawer(animationEntity: animationEntity);
    yield HomeInitialState(animationEntity: animationEntity);
  }
  Stream<HomeState>mapOpenDrawerEventToState() async* {
    yield OpenDrawerState();
    yield HomeInitialState(animationEntity: animationEntity);
  }

  Stream<HomeState> mapUserTapEventToState() async*{
    yield UserTapState();
    homeUseCase.closeDrawer(animationEntity: animationEntity);
    yield HomeInitialState(animationEntity: animationEntity);
  }

  Stream<HomeState> mapScrollEventToState()async* {
    yield ScrollState();
    homeUseCase.setAddTodoButtonBlur(animationEntity: animationEntity);
    yield HomeInitialState(animationEntity: animationEntity);

  }
  Stream<HomeState> mapScrollStopEventToState()async* {
    yield ScrollStopState();
    homeUseCase.resetAddTodoButtonOpacity(animationEntity: animationEntity);
    yield HomeInitialState(animationEntity: animationEntity);
  }
}

