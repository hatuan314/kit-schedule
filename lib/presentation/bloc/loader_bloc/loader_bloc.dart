import 'package:bloc/bloc.dart';
import 'bloc.dart';

class LoaderBloc extends Bloc<LoaderEvent, LoaderState> {
  LoaderBloc() : super(Loaded());


  @override
  Stream<LoaderState> mapEventToState(LoaderEvent event) async* {
    switch (event.runtimeType) {
      case StartLoading:
        yield* _loading(event as StartLoading);
        break;
      case FinishLoading:
        yield Loaded();
        break;
    }
  }

  Stream<LoaderState> _loading(StartLoading event) async* {
    yield Loading(isTopLoading: event.isTopLoading);
  }
}
