import 'package:schedule/src/service/services.dart';

class RepositoryOnline {
  final ProviderOnline _provider = ProviderOnline();
  Future<String> fetchScheduleSchoolDataRepo(String account, String password) =>
      _provider.fetchScheduleSchoolDataProvider(account, password);
}
