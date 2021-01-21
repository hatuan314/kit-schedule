import 'package:schedule/domain/entities/animation_entities.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_event.dart';

class HomeUseCase {
  AnimationEntity init(
      {AnimationEntity animationEntity, HomeInitEvent event}) {
    animationEntity = AnimationEntity(controller: event.animationController);
    return animationEntity;
  }

}
