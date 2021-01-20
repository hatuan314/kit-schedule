import 'package:get_it/get_it.dart';
import 'package:schedule/data/data_sources/local_data_sources/personal_local_data_sources.dart';

GetIt getIt = GetIt.instance;
void init(){

  ///Data source
  getIt.registerLazySingleton<PersonalLocalDataSource>(() => PersonalLocalDataSource());

}