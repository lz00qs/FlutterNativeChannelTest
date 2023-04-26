import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_native_channel_test_platform_interface.dart';

/// An implementation of [FlutterNativeChannelTestPlatform] that uses method channels.
class MethodChannelFlutterNativeChannelTest extends FlutterNativeChannelTestPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_native_channel_test/method');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getMethodTestResult() async {
    final result = await methodChannel.invokeMethod<String>('getMethodTestResult');
    return result;
  }

  @override
  Future<void> startNativeSendEvent() async {
    await methodChannel.invokeMethod<void>('startNativeSendEvent');
  }

  @override
  Future<void> stopNativeSendEvent() async {
    await methodChannel.invokeMethod<void>('stopNativeSendEvent');
  }
}
