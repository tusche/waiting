import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:waiting/scene/scene.dart';

class BlurSceneWidget extends SceneWidget {
  final Duration enterDuration;

  final Duration exitDuration;

  final Animation<double> Function(AnimationController animationController)
      sigma;

  const BlurSceneWidget({
    super.key,
    required super.scenes,
    required super.controller,
    required this.sigma,
    required this.enterDuration,
    required this.exitDuration,
    required super.child,
  });

  @override
  State<SceneWidget> createState() {
    return BlurSceneState();
  }
}

class BlurSceneState extends SceneWidgetState<BlurSceneWidget> {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 0),
    vsync: this,
  );
  late final Animation<double> _sigma = widget.sigma.call(_controller);

  BlurSceneState();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Future<void> onEnter() {
    _controller.duration = widget.enterDuration;
    return _controller.forward();
  }

  @override
  Future<void> onExit() {
    _controller.duration = widget.exitDuration;
    return _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
        imageFilter: ImageFilter.blur(
            sigmaX: _sigma.value,
            sigmaY: _sigma.value,
            tileMode: TileMode.decal),
        child: super.build(context));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
