import 'dart:html';
import 'dart:math';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import 'assets.dart';
import 'components/components.dart';
import 'core/logic.dart';
import 'core/managers/game_state_manager.dart';
import 'html/input/controller_system.dart';
import 'html/rendering/rendering_system.dart';

class Game extends GameBase {
  final GameStateManager gameStateManager;
  late final CanvasElement hud;
  Game(this.gameStateManager)
      : super(
          'ohgj_387',
          'canvas#game',
          spriteSheetImg: assetsImg,
          spriteSheetJson: assetsJson,
          bodyDefsName: null,
          webgl: true,
        ) {
    hud = querySelector('#hud')! as CanvasElement;
  }

  @override
  void createEntities() {
    final tagManager = world.getManager<TagManager>();
    final player = addEntity([
      Controller(),
      Position(0, 0),
      Acceleration(0, 0),
      Velocity(0, 0),
      Orientation(pi),
      Renderable(spriteSheet!, 'king'),
      Camera(),
    ]);
    tagManager
      ..register(player, cameraTag)
      ..register(player, playerTag);
    addEntity([
      Position(500, 500),
      Acceleration(0, 0),
      Velocity(0, 0),
      Orientation(pi),
      Renderable(spriteSheet!, 'knight'),
      Ai(),
    ]);
    addEntity([
      Position(200, 0),
      Acceleration(0, 0),
      Velocity(0, 0),
      Orientation(pi),
      Renderable(spriteSheet!, 'rook'),
      Ai(),
    ]);
    addEntity([
      Position(800, 0),
      Acceleration(0, 0),
      Velocity(0, 0),
      Orientation(pi),
      Renderable(spriteSheet!, 'bishop'),
      Ai(),
    ]);
  }

  @override
  Map<int, List<EntitySystem>> getSystems() => {
        GameBase.rendering: [
          ControllerSystem(),
          DragSystem(),
          ResetAccelerationSystem(),
          ControllerToActionSystem(),
          KingFollowingSystem(),
          SimpleAccelerationSystem(),
          SimpleMovementSystem(),
          WebGlCanvasCleaningSystem(gl!),
          RenderingSystem(gl!, spriteSheet!),
        ],
      };

  @override
  List<Manager> getManagers() => [
        gameStateManager,
        TagManager(),
        ViewProjectionMatrixManager(),
      ];
}
