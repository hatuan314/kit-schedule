import 'package:get_it/get_it.dart';
import 'package:schedule/blocs/calendar/calendar_bloc.dart';
import 'package:schedule/common/config/firebase_setup.dart';
import 'package:schedule/data/remote/data_remote.dart';
import 'package:schedule/data/reponsitories/schedule_repositories_impl.dart';
import 'package:schedule/domain/repositories/schedule_repositories.dart';
import 'package:schedule/domain/usecase/schedule_usecase.dart';
import 'package:schedule/presentation/bloc/loader_bloc/bloc.dart';
import 'package:schedule/presentation/bloc/snackbar_bloc/bloc.dart';
import 'package:schedule/presentation/journey/sign_in_screen.dart/bloc/register_bloc.dart';
import 'package:schedule/presentation/journey/todo_screen/bloc/todo_bloc.dart';

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
    getIt.registerFactory<RegisterBloc>(() => RegisterBloc(
        snackbarBloc: getIt<SnackbarBloc>(),
        scheduleUseCase: getIt<ScheduleUseCase>()));
    getIt.registerLazySingleton<CalendarBloc>(() => CalendarBloc());
    getIt.registerFactory<TodoBloc>(() => TodoBloc(
        snackbarBloc: getIt<SnackbarBloc>(),
        calendarBloc: getIt<CalendarBloc>()));
  }

  static void _configUseCase() {
    getIt.registerFactory<ScheduleUseCase>(
        () => ScheduleUseCase(getIt<ScheduleRepositories>()));
  }

  static void _configRepository() {
    getIt.registerLazySingleton<ScheduleRepositories>(
        () => ScheduleRepositoriesImpl(getIt<DataRemote>()));
  }

  static void _configDataSource() {
    getIt.registerLazySingleton<DataRemote>(
        () => DataRemote(firebaseSetup: getIt<FirebaseSetup>()));
    getIt.registerLazySingleton<FirebaseSetup>(() => FirebaseSetup());
  }

  static void _configNetwork() {}
  static void _configCommon() {}
}
