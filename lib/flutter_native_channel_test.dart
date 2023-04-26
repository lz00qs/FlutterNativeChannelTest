
import 'flutter_native_channel_test_platform_interface.dart';

class FlutterNativeChannelTest {
  Future<String?> getPlatformVersion() {
    return FlutterNativeChannelTestPlatform.instance.getPlatformVersion();
  }

  Future<String?> getMethodTestResult() {
    return FlutterNativeChannelTestPlatform.instance.getMethodTestResult();
  }

  Future<void> startNativeSendEvent() {
    return FlutterNativeChannelTestPlatform.instance.startNativeSendEvent();
  }

  Future<void> stopNativeSendEvent() {
    return FlutterNativeChannelTestPlatform.instance.stopNativeSendEvent();
  }
}
