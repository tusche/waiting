import 'dart:async';

import 'package:flutter/widgets.dart';

import 'scene_controller.dart';

abstract class SceneWidget extends StatefulWidget {
  final SceneController controller;

  final bool Function(dynamic) scenes;

  final Widget child;

  const SceneWidget(
      {super.key,
      required this.scenes,
      required this.controller,
      required this.child});
}

abstract class SceneWidgetState<T extends SceneWidget> extends State<T>
    with TickerProviderStateMixin {
  bool _active = false;

  Future<void> enter() {
    return onEnter();
  }

  Future<void> onEnter();

  Future<void> exit() {
    return onExit();
  }

  Future<void> onExit();

  @override
  Widget build(BuildContext context) {
    var scene = widget.controller.getScene();
    var isInScene = widget.scenes(scene);
    if (isInScene) {
      if (!_active) {
        _active = true;
        enter();
      }
    } else {
      if (_active) {
        _active = false;
        exit();
      }
    }
    return widget.child;
  }
}
