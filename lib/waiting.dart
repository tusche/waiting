import 'package:flutter/material.dart';
import 'package:waiting/scene/scene_controller.dart';
import 'package:waiting/scene/scene_fade.dart';

enum Waiting { scrim, progress, timeout }

class WaitingWidget extends StatefulWidget {
  final bool show;

  final Widget child;

  final Widget indicator;

  final Widget timeoutIndicator;

  final Duration? timeout;

  const WaitingWidget(
      {super.key,
      required this.show,
      required this.child,
      this.indicator = const DefaultIndicator(),
      this.timeoutIndicator = const DefaultTimeoutIndicator(),
      this.timeout = null});

  @override
  State<StatefulWidget> createState() => WaitingWidgetState();
}

class WaitingWidgetState extends State<WaitingWidget> {
  late SceneController _controller = SceneController(this, Waiting.values);

  @override
  Widget build(BuildContext context) {
    if (widget.show) {
      if (!_isShown()) {
        _show();
      }
    } else {
      if (_isShown()) {
        _hide();
      }
    }
    return Stack(children: [
      WaitingScrimWidget(controller: _controller, child: widget.child),
      WaitingProgressWidget(
          controller: _controller, indicator: widget.indicator),
      WaitingTimeoutWidget(
          controller: _controller, indicator: widget.timeoutIndicator)
    ]);
  }

  bool _isShown() => _controller.getScene() != null;

  void _show() {
    _controller.schedule(Waiting.scrim);
    _controller.schedule(Waiting.progress,
        delayed: const Duration(milliseconds: 200));
    if (widget.timeout != null) {
      _controller.schedule(Waiting.timeout, delayed: widget.timeout);
    }
  }

  void _hide() {
    _controller.reset();
  }
}

class WaitingScrimWidget extends StatelessWidget {
  const WaitingScrimWidget({
    super.key,
    required this.controller,
    required this.child,
  });

  final SceneController controller;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeSceneWidget(
      controller: controller,
      scenes: all(),
      opacity: (AnimationController animationController) {
        return Tween<double>(
          begin: 1.0,
          end: 0.33,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut, // Apply curve here
        ));
      },
      enterDuration: const Duration(milliseconds: 200),
      exitDuration: const Duration(milliseconds: 200),
      child: child,
    );
  }
}

class WaitingProgressWidget extends StatelessWidget {
  const WaitingProgressWidget(
      {super.key,
      required this.controller,
      this.indicator = const DefaultIndicator()});

  final SceneController controller;

  final Widget indicator;

  @override
  Widget build(BuildContext context) {
    return FadeSceneWidget(
      controller: controller,
      scenes: value(Waiting.progress),
      opacity: (AnimationController animationController) {
        return Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut, // Apply curve here
        ));
      },
      enterDuration: const Duration(milliseconds: 400),
      exitDuration: const Duration(milliseconds: 200),
      child: indicator,
    );
  }
}

class WaitingTimeoutWidget extends StatelessWidget {
  const WaitingTimeoutWidget(
      {super.key,
      required this.controller,
      this.indicator = const DefaultTimeoutIndicator()});

  final SceneController controller;

  final Widget indicator;

  @override
  Widget build(BuildContext context) {
    return FadeSceneWidget(
      controller: controller,
      scenes: value(Waiting.timeout),
      opacity: (AnimationController animationController) {
        return Tween<double>(
          begin: 0,
          end: 1,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut, // Apply curve here
        ));
      },
      enterDuration: const Duration(milliseconds: 400),
      exitDuration: const Duration(milliseconds: 200),
      child: indicator,
    );
  }
}

class DefaultIndicator extends StatelessWidget {
  const DefaultIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class DefaultTimeoutIndicator extends StatelessWidget {
  const DefaultTimeoutIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
            width: 100,
            height: 16,
            child: LinearProgressIndicator()));
  }
}
