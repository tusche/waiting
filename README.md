## Introduction

Waiting is a part of any app: loading resources takes time and the user needs to wait. While loading the app has to inform the user that he has to wait.

This package provides a `WaitingWidget`: a widget showing a progress indicator, including transitions, animations and customizations.

## Getting started
Add the dependency to your flutter project:
```dart
dependencies:
  waiting: ^1.0.0
```

Import the package:
```
import 'package:waiting/waiting.dart';
```

Wrap any widget with `WaitingWidget`:
```
WaitingWidget(
  show: _show,
  child: const Center(
      child: SizedBox(width: 200, height: 200, child: FlutterLogo())));
```

If the given variable `_show` is set to true the wrapped widget will be scrimmed (faded out) and overlayed with a circular progress indicator. When `_show` is set to false again, the wrapped widget returns to its normal state:

[![screen](https://raw.githubusercontent.com/tusche/waiting/main/assets/example.gif)](https://www.github.com/tusche/waiting)

See the [example](https://github.com/tusche/waiting/blob/main/example/lib/main.dart) for the complete code.

## Customization

### Setting the indicator

To change the indicator, set `ìndicator` when creating the `WaitingWidget`. 

For example if a [Lottie](https://pub.dev/packages/lottie) animation should be used as the indicator widget:

```
WaitingWidget(
          indicator: Center(
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                      child: Lottie.asset("assets/infinite.json")))),
          show: _show,
          child: const Center(
              child: SizedBox(width: 200, height: 200, child: FlutterLogo()))),
```

the result looks like this:

[![screen](https://raw.githubusercontent.com/tusche/waiting/main/assets/example_indicator.gif)](https://www.github.com/tusche/waiting)

### Setting a timeout

After a certain period of waiting the user should be informed that the waiting will take a bit longer or give the user the possibility to cancel the operation that causes the waiting.

The `WaitingWidget` offers the paramter `timeout` to specify a duration after which a timeout widget is displayed:

```
WaitingWidget(
  show: _show,
  timeout: const Duration(second: 5),
  child: const Center(
      child: SizedBox(width: 200, height: 200, child: FlutterLogo())));
```

The result looks like this:

[![screen](https://raw.githubusercontent.com/tusche/waiting/main/assets/example_timeout_default.gif)](https://www.github.com/tusche/waiting)

To specify an indicator for the time, the parameter `timeoutIndicator` is used:

```
WaitingWidget(
  show: _show,
  timeout: const Duration(second: 5),
  timeoutIndicator: const Center(child: Text("please wait...")),
  child: const Center(
      child: SizedBox(width: 200, height: 200, child: FlutterLogo())));
```

The result looks like this:

[![screen](https://raw.githubusercontent.com/tusche/waiting/main/assets/example_timeout_indicator.gif)](https://www.github.com/tusche/waiting)

### Beyond

The `WaitingWidget` uses a `SceneController` and widgets using `SceneWidget` implementations internally to transist between "scenes".

Check out [waiting.dart](https://github.com/tusche/waiting/blob/main/lib/waiting.dart) to see how its done and get inspired.

Also check out the [source](https://github.com/tusche/waiting_presentation) for the companion presentation presented at the [fluttercon 2024](https://fluttercon.dev/andre-schmidt-di-salvo/) to see how "scenes" can be used to build e.g. a presentation.
