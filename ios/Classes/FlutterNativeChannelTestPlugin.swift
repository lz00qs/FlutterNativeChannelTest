import Flutter
import UIKit

public class FlutterNativeChannelTestPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    var eventSink: FlutterEventSink?
    let queue = DispatchQueue(label: "top.hylcreative.asyncloop")
    var flag = 0
    
    init(messenger: FlutterBinaryMessenger) {
        super.init()
        let eventChannel = FlutterEventChannel(name: "flutter_native_channel_test/event", binaryMessenger: messenger)
        eventChannel.setStreamHandler(self)
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "flutter_native_channel_test/method", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "flutter_native_channel_test/event", binaryMessenger: registrar.messenger())
        let instance = FlutterNativeChannelTestPlugin(messenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS" + UIDevice.current.systemVersion)
        case "getMethodTestResult":
            result("iOS native method channel is called!!!")
        case "startNativeSendEvent":
            guard let mEventSink = eventSink else {
                return
            }
            flag = 1
            mEventSink("Start iOS event channel test")
            let loop = {
                var i = 0
                self.queue.async {
                    while self.flag == 1 {
                        mEventSink("iOS event channel test: \(i)")
                        i += 1
                        if i == 100 {
                            i = 0
                        }
                        sleep(1)
                    }
                }
            }
            result(nil)
            loop()
        case "stopNativeSendEvent":
            flag = 0
            guard let mEventSink = eventSink else {
                return
            }
            mEventSink("Stop iOS event channel test")
            result(nil)
        default:
            result(FlutterError(code: "Unimplement", message: nil, details: nil))
        }
    }
}
