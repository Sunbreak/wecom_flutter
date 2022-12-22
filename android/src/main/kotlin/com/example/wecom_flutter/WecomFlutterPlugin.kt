package com.example.wecom_flutter

import android.content.Context
import androidx.annotation.NonNull
import com.tencent.wework.api.IWWAPI
import com.tencent.wework.api.IWWAPIEventHandler
import com.tencent.wework.api.WWAPIFactory
import com.tencent.wework.api.model.WWAuthMessage
import com.tencent.wework.api.model.WWBaseMessage
import com.tencent.wework.api.model.WWMediaLink
import com.tencent.wework.api.model.WWMediaMessage

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WecomFlutterPlugin */
class WecomFlutterPlugin: FlutterPlugin, MethodCallHandler {

  private lateinit var appContext: Context

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var wwapi: IWWAPI

  private lateinit var schema: String

  private var appId: String? = null

  private var agentId: String? = null

  private fun WWBaseMessage.appendRegInfo() {
    this.schema = this@WecomFlutterPlugin.schema
    this.appId = this@WecomFlutterPlugin.appId
    this.agentId = this@WecomFlutterPlugin.agentId
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    appContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wecom_flutter")
    channel.setMethodCallHandler(this)
    wwapi = WWAPIFactory.createWWAPI(appContext)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "registerApp") {
      val args = call.arguments as Map<String, Any>
      schema = args["schema"] as String
      appId = args["appId"] as String
      agentId = args["agentId"] as String
      val registered = wwapi.registerApp(schema)
      result.success(registered)
    } else if (call.method == "isWWAppInstalled") {
      result.success(wwapi.isWWAppInstalled)
    } else if (call.method == "sendWeComAuth") {
      val args = call.arguments as Map<String, Any>
      val req = WWAuthMessage.Req().apply {
        state = args["state"] as? String
        appendRegInfo()
        sch = schema
      }
      result.success(wwapi.sendMessage(req, eventHandler))
    } else if (call.method == "shareToWeCom") {
      val args = call.arguments as Map<String, Any>
      val type = args["type"] as String
      val model = args["model"] as Map<String, Any>
      val req = buildShareRequest(type, model)
      if (req != null) {
        result.success(wwapi.sendMessage(req, eventHandler))
      } else {
        result.error("ArgumentError", null, null)
      }
    } else {
      result.notImplemented()
    }
  }

  private val eventHandler = IWWAPIEventHandler { msg ->
    if (msg is WWAuthMessage.Resp) {
      channel.invokeMethod("onAuthResponse", mapOf(
        "errCode" to msg.errCode,
        "code" to msg.code,
        "state" to msg.state,
      ))
    }
  }

  private fun buildShareRequest(type: String, model: Map<String, Any>): WWMediaMessage? {
    return when (type) {
      "WeComShareWebPageModel" -> {
        WWMediaLink().apply {
          webpageUrl = model["url"] as String
          title = model["title"] as? String
          appPkg = appContext.packageName
          appendRegInfo()
        }
      }
      else -> null
    }
  }
}
