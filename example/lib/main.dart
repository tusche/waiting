import 'package:flutter/material.dart';
import 'package:waiting/waiting.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waiting Example',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true),
      home: Example(),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<StatefulWidget> createState() => ExampleState();
}

class ExampleState extends State<Example> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaitingWidget(
          show: _show,
          child: const Center(
              child: SizedBox(width: 200, height: 200, child: FlutterLogo()))),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggle,
        child: !_show ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _show = !_show;
    });
  }
}
