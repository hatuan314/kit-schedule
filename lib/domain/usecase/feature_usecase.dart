import 'package:schedule/domain/repositories/features_repository.dart';

class FeatureUsecase {
  final FeatureRepository featureRepository;

  const FeatureUsecase({
    required this.featureRepository,
  });

  Future<bool?> getIsAccountFeaturesEnabled() async {
    return featureRepository.enableAccountFeatures();
  }
}
