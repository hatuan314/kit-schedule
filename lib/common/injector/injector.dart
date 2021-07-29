import 'package:get_it/get_it.dart';
import 'package:schedule/presentation/bloc/loader_bloc/bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/bloc.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/bloc/register_bloc.dart';

class Injector {
  static final getIt = GetIt.instance;
  static void setup() {
    _configuration();
  }

  static void _configuration() {
    _configBloc();
    _configUseCase();
    _configRepository();
    _configDataSource();
    _configNetwork();
    _configCommon();
  }

  static void _configBloc() {
    getIt.registerSingleton<LoaderBloc>(LoaderBloc());
    getIt.registerSingleton<SnackbarBloc>(SnackbarBloc());
    getIt.registerFactory<RegisterBloc>(
        () => RegisterBloc(snackbarBloc: getIt<SnackbarBloc>()));
  }

  static void _configUseCase() {}
  static void _configRepository() {}
  static void _configDataSource() {}
  static void _configNetwork() {}
  static void _configCommon() {}
}
