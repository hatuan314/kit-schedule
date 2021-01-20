
import 'package:get_it/get_it.dart';
import 'package:schedule/domain/usecases/HomeUseCase.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_bloc.dart';

GetIt getIt = GetIt.instance;

void configureDependencies() {
  ///data source
  ///repository
  ///use case
  getIt.registerFactory<HomeUseCase>(()=>HomeUseCase());
  ///bloc
  getIt.registerFactory<HomeBloc>(() => HomeBloc(homeUseCase:  getIt<HomeUseCase>()));
}