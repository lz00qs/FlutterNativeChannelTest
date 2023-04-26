import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_native_channel_test_method_channel.dart';

abstract class FlutterNativeChannelTestPlatform extends PlatformInterface {
  /// Constructs a FlutterNativeChannelTestPlatform.
  FlutterNativeChannelTestPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterNativeChannelTestPlatform _instance = MethodChannelFlutterNativeChannelTest();

  /// The default instance of [FlutterNativeChannelTestPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterNativeChannelTest].
  static FlutterNativeChannelTestPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterNativeChannelTestPlatform] when
  /// they register themselves.
  static set instance(FlutterNativeChannelTestPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getMethodTestResult() {
    throw UnimplementedError('getMethodTestResult() has not been implemented.');
  }

  Future<void> startNativeSendEvent() {
    throw UnimplementedError('startNativeSendEvent() has not been implemented.');
  }

  Future<void> stopNativeSendEvent() {
    throw UnimplementedError('stopNativeSendEvent() has not been implemented.');
  }
}
