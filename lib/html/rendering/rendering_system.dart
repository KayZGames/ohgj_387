import 'dart:web_gl';
import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

part 'rendering_system.g.dart';

@Generate(
  WebGlSpriteRenderingSystem,
  allOf: [
    Velocity,
  ],
)
class RenderingSystem extends _$RenderingSystem {
  late UniformLocation uViewProjectionLocation;
  late UniformLocation uSizeLocation;
  late UniformLocation uTextureLocation;

  RenderingSystem(super.gl, super.sheet);

  @override
  void initUniformLocations() {
    uViewProjectionLocation = getUniformLocation('uViewProjection');
    uSizeLocation = getUniformLocation('uSize');
    uTextureLocation = getUniformLocation('uTexture');
  }
}
