import 'package:get_it/get_it.dart';
import 'package:schedule/data/data_sources/local_data_sources/personal_schedule_local_data_sources.dart';
import 'package:schedule/data/repositories_impl/offline_schedule_repository_impl.dart';
import 'package:schedule/data/repositories_impl/personal_schedule_repository_impl.dart';
import 'package:schedule/data/repositories_impl/school_schedule_repository_impl.dart';
import 'package:schedule/domain/repositories/offlineRepository.dart';
import 'package:schedule/domain/repositories/personal_schedule_repository.dart';
import 'package:schedule/domain/repositories/school_schedule_repository.dart';
import 'package:schedule/domain/use_cases/HomeUseCase.dart';
import 'package:schedule/domain/use_cases/schedule_use_case.dart';
import 'package:schedule/domain/use_cases/search_use_case.dart';
import 'package:schedule/domain/use_cases/todo_use_case.dart';
import 'package:schedule/presentation/screen/home_screen/calendarView/bloc/calendar_bloc.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:schedule/presentation/screen/search_screen/bloc/search_bloc.dart';
import 'package:schedule/presentation/screen/todo_screen/bloc/todo_bloc.dart';

GetIt getIt = GetIt.instance;

void  configureDependencies() {
  ///data source
  getIt.registerLazySingleton<PersonalScheduleLocalDataSource>(
      () => PersonalScheduleLocalDataSource());

  ///repository
  getIt.registerLazySingleton<PersonalScheduleRepository>(() =>
      PersonalScheduleRepositoryImpl(
          dataSource: getIt<PersonalScheduleLocalDataSource>()));
getIt.registerLazySingleton<OfflineRepository>(() =>
    OfflineRepositoryImpl(
          ));

  ///use case
  getIt.registerFactory<HomeUseCase>(() => HomeUseCase());
  getIt.registerFactory<TodoUseCase>(
      () => TodoUseCase(repository: getIt<PersonalScheduleRepository>()));
  getIt.registerFactory<SearchUseCase>(() => SearchUseCase(
      personalScheduleRepository: getIt<PersonalScheduleRepository>()));
getIt.registerFactory<ScheduleUseCase>(() => ScheduleUseCase(
      repositoryOffline: getIt<OfflineRepository>()));

  ///bloc
  getIt.registerFactory<HomeBloc>(
      () => HomeBloc(homeUseCase: getIt<HomeUseCase>()));
  getIt.registerFactory<CalendarBloc>(
      () => CalendarBloc(scheduleUseCase: getIt<ScheduleUseCase>()));
  getIt
      .registerFactory<TodoBloc>(() => TodoBloc(useCase: getIt<TodoUseCase>()));
  getIt.registerFactory<SearchBloc>(
      () => SearchBloc(useCase: getIt<SearchUseCase>()));
}
