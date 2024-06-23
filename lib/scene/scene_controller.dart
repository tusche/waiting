// ignore_for_file: INVALID_USE_OF_PROTECTED_MEMBER

import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/widgets.dart';

bool Function(dynamic) all() => (e) => e != null ? true : false;

bool Function(dynamic) value(dynamic level) => (e) => level == e;

bool Function(dynamic) values(List<dynamic> levels) =>
    (e) => levels.contains(e);

bool Function(dynamic) range(dynamic from, dynamic to, List<dynamic> levels) =>
    (e) => _range(e, from, to, levels);

bool _range(dynamic e, dynamic from, dynamic to, List<dynamic> levels) {
  var fromIndex = levels.indexOf(from);
  var index = levels.indexOf(e);
  var toIndex = levels.indexOf(to);
  return index >= fromIndex && index <= toIndex;
}

bool Function(dynamic) from(dynamic from, List<dynamic> levels) =>
    (e) => _range(e, from, levels.last, levels);

bool Function(dynamic) to(dynamic to, List<dynamic> levels) =>
    (e) => _range(e, levels.first, to, levels);

class SceneController {
  final State _state;

  final List<dynamic> _scenes;

  var _currentIndex = -1;

  final Map<Future, CancelableOperation> _cancelOperations = {};

  SceneController(this._state, this._scenes);

  Future<void> schedule(dynamic scene, {Duration? delayed}) {
    if (delayed != null) {
      var future = Future.delayed(delayed);
      var cancelOperation = CancelableOperation.fromFuture(future)
          .then((value) => _state.setState(() {
                _setScene(scene);
              }));
      _cancelOperations[future] = cancelOperation;
      return future;
    } else {
      _setScene(scene);
      return Future.value();
    }
  }

  void _setScene(dynamic scene) {
    if (scene == null) {
      _currentIndex = -1;
      return;
    }
    var index = _scenes.indexOf(scene);
    if (index == -1) {
      throw Exception("invalid index for level ${scene.toString()}");
    }
    _currentIndex = index;
  }

  void cancel(Future future) {
    var cancelOperation = _cancelOperations.remove(future);
    if (cancelOperation != null) {
      cancelOperation.cancel();
    }
  }

  void cancelAll() {
    for (var cancelOperation in _cancelOperations.values) {
      cancelOperation.cancel();
    }
    _cancelOperations.clear();
  }

  void reset() {
    cancelAll();
    _setScene(null);
  }

  dynamic getScene() => _currentIndex != -1 ? _scenes[_currentIndex] : null;

  dynamic forward() {
    var isAtLastIndex = _currentIndex == _scenes.length - 1;
    if (isAtLastIndex) {
      return null;
    } else {
      return _scenes[_currentIndex + 1];
    }
  }

  dynamic back() {
    var isAtFirstIndex = _currentIndex == 0;
    if (isAtFirstIndex) {
      return null;
    } else {
      return _scenes[_currentIndex - 1];
    }
  }
}
