import Flutter
import UIKit

public class SwiftWecomFlutterPlugin: NSObject, FlutterPlugin {
  private var channel: FlutterMethodChannel!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftWecomFlutterPlugin()
    registrar.addApplicationDelegate(instance)
    instance.channel = FlutterMethodChannel(name: "wecom_flutter", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: instance.channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "registerApp") {
      let args = call.arguments as! Dictionary<String, Any>
      let schema = args["schema"] as! String
      let appId = args["appId"] as! String
      let agentId = args["agentId"] as! String
      let registered = WWKApi.registerApp(schema, corpId: appId, agentId: agentId)
      result(registered)
    } else if (call.method == "isWWAppInstalled") {
      result(WWKApi.isAppInstalled())
    } else if (call.method == "sendWeComAuth") {
      let args = call.arguments as! Dictionary<String, Any>
      let req = WWKSSOReq()
      req.state = args["state"] as? String ?? ""
      result(WWKApi.send(req))
    } else if (call.method == "shareToWeCom") {
      let args = call.arguments as! Dictionary<String, Any>
      let type = args["type"] as! String
      let model = args["model"] as! Dictionary<String, Any>
      let req = buildShareRequest(type, model)
      if (req != nil) {
        result(WWKApi.send(req))
      } else {
        result(FlutterError(code: "ArgumentError", message: nil, details: nil))
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}

extension SwiftWecomFlutterPlugin: WWKApiDelegate {
  public func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return WWKApi.handleOpen(url, delegate: self)
  }

  public func onResp(_ resp: WWKBaseResp) {
    if let authResp = resp as? WWKSSOResp {
      self.channel.invokeMethod("onAuthResponse", arguments: [
        "errCode": authResp.errCode,
        "code": authResp.code,
        "state": authResp.state,
      ])
    }
  }
}

extension SwiftWecomFlutterPlugin {
  private func buildShareRequest(_ type: String, _ model: Dictionary<String, Any>) -> WWKSendMessageReq? {
    switch (type) {
    case "WeComShareWebPageModel": do {
      let attachment = WWKMessageLinkAttachment()
      attachment.url = model["url"] as! String
      attachment.title = model["title"] as? String
      let req = WWKSendMessageReq()
      req.attachment = attachment
      return req
    }
    default:
      return nil
    }
  }
}
