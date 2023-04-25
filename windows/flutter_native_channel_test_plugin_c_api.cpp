#include "include/flutter_native_channel_test/flutter_native_channel_test_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_native_channel_test_plugin.h"

void FlutterNativeChannelTestPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_native_channel_test::FlutterNativeChannelTestPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
