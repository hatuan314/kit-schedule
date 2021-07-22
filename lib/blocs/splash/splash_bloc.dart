import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/service/services.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  ShareService _shareService = ShareService();

  SplashBloc() : super(CheckDataLoadingState());

  @override
  Stream<SplashState> mapEventToState(SplashEvent event) async* {
    // TODO: implement mapEventToState
    if (event is CheckOfflineData) {
      try {
        bool? flag = await _shareService.getIsSaveData();
        if (flag == false) {
          yield CheckNoDataState();
        } else {
          yield CheckDataSuccessState();
        }
      } catch (e) {
        yield CheckDataFailureState(e.toString());
      }
    }
  }
}
