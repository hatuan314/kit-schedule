import 'package:schedule/domain/entities/animation_entities.dart';
import 'package:schedule/presentation/screen/home_screen/home_bloc/home_event.dart';

class HomeUseCase {
  AnimationEntity init({AnimationEntity animationEntity, HomeInitEvent event}) {
    animationEntity = AnimationEntity(controller: event.animationController);
    return animationEntity;
  }

  void switchDrawer({AnimationEntity animationEntity}) {
    animationEntity.switchDrawer();
  }

  void closeDrawer({AnimationEntity animationEntity}) {
    animationEntity.closeDrawer();
  }

  void setAddTodoButtonBlur({AnimationEntity animationEntity}) {
    animationEntity.setAddTodoButtonBlur();
  }

  void resetAddTodoButtonOpacity({AnimationEntity animationEntity}) {
    animationEntity.resetAddTodoButtonOpacity();
  }
}
