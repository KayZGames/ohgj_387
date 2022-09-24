import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../components/components.dart';

part 'logic.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Controller,
    Acceleration,
  ],
)
class ControllerToActionSystem extends _$ControllerToActionSystem {
  final _acc = 100000.0;
  final _sqrttwo = 1.4142;

  @override
  void processEntity(
    int entity,
    Controller controller,
    Acceleration acceleration,
  ) {
    if (controller.up) {
      acceleration.y += _acc * world.delta;
    } else if (controller.down) {
      acceleration.y -= _acc * world.delta;
    } else if (controller.left) {
      acceleration.x -= _acc * world.delta;
    } else if (controller.right) {
      acceleration.x += _acc * world.delta;
    } else if (controller.upleft) {
      acceleration
        ..y += _acc * world.delta / _sqrttwo
        ..x -= _acc * world.delta / _sqrttwo;
    } else if (controller.upright) {
      acceleration
        ..y += _acc * world.delta / _sqrttwo
        ..x += _acc * world.delta / _sqrttwo;
    } else if (controller.downleft) {
      acceleration
        ..y -= _acc * world.delta / _sqrttwo
        ..x -= _acc * world.delta / _sqrttwo;
    } else if (controller.downright) {
      acceleration
        ..y -= _acc * world.delta / _sqrttwo
        ..x += _acc * world.delta / _sqrttwo;
    }
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    Velocity,
  ],
)
class DragSystem extends _$DragSystem {
  @override
  void processEntity(int entity, Velocity velocity) {
    velocity
      ..x *= 0.9
      ..y *= 0.9;
  }
}

@Generate(
  EntityProcessingSystem,
  allOf: [
    Ai,
    Position,
    Acceleration,
  ],
  manager: [
    TagManager,
  ],
)
class KingFollowingSystem extends _$KingFollowingSystem {
  late Position playerPos;

  @override
  void begin() {
    final player = tagManager.getEntity(playerTag)!;
    playerPos = positionMapper[player];
  }

  @override
  void processEntity(
    int entity,
    Ai ai,
    Position position,
    Acceleration acceleration,
  ) {
    final xDiff = playerPos.x - position.x;
    final yDiff = playerPos.y - position.y;

    acceleration
      ..x = 50000 * xDiff.sign * delta
      ..y = 50000 * yDiff.sign * delta;
  }
}
