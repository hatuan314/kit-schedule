import 'package:schedule/data/remote/data_remote.dart';
import 'package:schedule/domain/repositories/features_repository.dart';

class FeatureRepositoryImpl implements FeatureRepository {
  final DataRemote dataRemote;

  const FeatureRepositoryImpl({
    required this.dataRemote,
  });

  @override
  Future<bool?> enableAccountFeatures() async {
    final developDocument =
        await dataRemote.fetchDevelopDocumentFirebase() as Map<String, dynamic>;
    return developDocument["enable_account_features"] as bool?;
  }
}
