import Flutter
import UIKit

public class SwiftWecomFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "wecom_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftWecomFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "registerApp") {
      let args = call.arguments as! Dictionary<String, Any>
      let schema = args["schema"] as! String
      let appId = args["appId"] as! String
      let agentId = args["agentId"] as! String
      let registered = WWKApi.registerApp(schema, corpId: appId, agentId: agentId)
      result(registered)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
