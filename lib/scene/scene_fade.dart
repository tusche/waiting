import 'package:flutter/cupertino.dart';
import 'package:waiting/scene/scene.dart';

class FadeSceneWidget extends SceneWidget {
  final Duration enterDuration;

  final Duration exitDuration;

  final Animation<double> Function(AnimationController animationController)
      opacity;

  const FadeSceneWidget({super.key,
    required super.scenes,
    required super.controller,
    required this.opacity,
    required this.enterDuration,
    required this.exitDuration,
    required super.child,
  });

  @override
  State<SceneWidget> createState() {
    return FadeSceneState();
  }
}

class FadeSceneState extends SceneWidgetState<FadeSceneWidget> {
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 0),
    vsync: this,
  );
  late final Animation<double> _opacity = widget.opacity.call(_controller);

  FadeSceneState();

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
    return FadeTransition(
      opacity: _opacity,
      child: super.build(context),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
