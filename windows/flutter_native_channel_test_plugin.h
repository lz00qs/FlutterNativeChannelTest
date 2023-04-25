#ifndef FLUTTER_PLUGIN_FLUTTER_NATIVE_CHANNEL_TEST_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_NATIVE_CHANNEL_TEST_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_native_channel_test {

class FlutterNativeChannelTestPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterNativeChannelTestPlugin();

  virtual ~FlutterNativeChannelTestPlugin();

  // Disallow copy and assign.
  FlutterNativeChannelTestPlugin(const FlutterNativeChannelTestPlugin&) = delete;
  FlutterNativeChannelTestPlugin& operator=(const FlutterNativeChannelTestPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_native_channel_test

#endif  // FLUTTER_PLUGIN_FLUTTER_NATIVE_CHANNEL_TEST_PLUGIN_H_
