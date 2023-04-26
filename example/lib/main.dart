import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_native_channel_test/flutter_native_channel_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _testResult = '';
  final _flutterNativeChannelTestPlugin = FlutterNativeChannelTest();
  StreamSubscription<String?>? _streamSubscription;
  bool _eventChannelStarted = false;
  final _eventChannel = const EventChannel('flutter_native_channel_test/event');

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterNativeChannelTestPlugin.getPlatformVersion() ??
              'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void _onEvent(Object? event) {
    setState(() {
      _testResult = event.toString();
    });
  }

  void _onError(Object error) {
    setState(() {
      _testResult = 'EventChannel error: $error';
    });
  }

  Future<void> startTestEventChannel() async {
    await _flutterNativeChannelTestPlugin.startNativeSendEvent();

    setState(() {
      _eventChannelStarted = true;
    });
  }

  Future<void> stopTestEventChannel() async {
    await _flutterNativeChannelTestPlugin.stopNativeSendEvent();

    _streamSubscription?.cancel();
    setState(() {
      _eventChannelStarted = false;
    });
  }

  Future<void> testMethodChannel() async {
    String result;
    try {
      result = await _flutterNativeChannelTestPlugin.getMethodTestResult() ??
          'Method channel test failed.';
    } on PlatformException {
      result = 'Failed to test method channel.';
    }

    if (!mounted) return;

    setState(() {
      _testResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                  onPressed: () async {
                    print("$_eventChannelStarted");
                    _eventChannelStarted
                        ? stopTestEventChannel()
                        : startTestEventChannel();
                  },
                  child: _eventChannelStarted
                      ? const Text('Native stop send event message')
                      : const Text('Native start send event message')),
              ElevatedButton(
                  onPressed: () async {
                    testMethodChannel();
                  },
                  child: const Text('Test method channel')),
              const SizedBox(height: 20),
              Text('Test result: $_testResult\n'),
            ],
          ),
        ),
      ),
    );
  }
}
