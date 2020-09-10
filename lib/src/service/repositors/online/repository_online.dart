import 'package:schedule/src/models/account_model.dart';
import 'package:schedule/src/service/services.dart';

class RepositoryOnline {
  final ProviderOnline _provider = ProviderOnline();
  Future<String> fetchScheduleSchoolDataRepo(AccountModel accountModel) =>
      _provider.fetchScheduleSchoolDataProvider(accountModel);
}
