import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_native_channel_test/flutter_native_channel_test.dart';
import 'package:flutter_native_channel_test/flutter_native_channel_test_platform_interface.dart';
import 'package:flutter_native_channel_test/flutter_native_channel_test_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterNativeChannelTestPlatform
    with MockPlatformInterfaceMixin
    implements FlutterNativeChannelTestPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterNativeChannelTestPlatform initialPlatform = FlutterNativeChannelTestPlatform.instance;

  test('$MethodChannelFlutterNativeChannelTest is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterNativeChannelTest>());
  });

  test('getPlatformVersion', () async {
    FlutterNativeChannelTest flutterNativeChannelTestPlugin = FlutterNativeChannelTest();
    MockFlutterNativeChannelTestPlatform fakePlatform = MockFlutterNativeChannelTestPlatform();
    FlutterNativeChannelTestPlatform.instance = fakePlatform;

    expect(await flutterNativeChannelTestPlugin.getPlatformVersion(), '42');
  });
}
