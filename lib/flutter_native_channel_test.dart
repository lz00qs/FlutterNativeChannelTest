
import 'flutter_native_channel_test_platform_interface.dart';

class FlutterNativeChannelTest {
  Future<String?> getPlatformVersion() {
    return FlutterNativeChannelTestPlatform.instance.getPlatformVersion();
  }
}
