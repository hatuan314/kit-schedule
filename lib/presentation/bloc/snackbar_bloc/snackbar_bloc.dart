import 'package:bloc/bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_event.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/snackbar_state.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(InitialSnackbarState());

  @override
  Stream<SnackbarState> mapEventToState(SnackbarEvent event) async* {
    if (event is ShowSnackbar) {
      yield ShowSnackBarState(
        title: event.title,
        type: event.type,
        key: event.key,
      );
    }
  }
}
