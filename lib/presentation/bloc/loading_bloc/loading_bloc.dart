import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/presentation/bloc/loading_bloc/loading_event.dart';
import 'package:schedule/presentation/bloc/loading_bloc/loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent,LoadingState>{
  @override
  LoadingState get initialState => LoadingInitState();

  @override
  Stream<LoadingState> mapEventToState(LoadingEvent event)async* {
  }

}