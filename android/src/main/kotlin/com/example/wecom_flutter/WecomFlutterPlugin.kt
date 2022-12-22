package com.example.wecom_flutter

import androidx.annotation.NonNull
import com.tencent.wework.api.IWWAPI
import com.tencent.wework.api.WWAPIFactory

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** WecomFlutterPlugin */
class WecomFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private lateinit var wwapi: IWWAPI

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "wecom_flutter")
    channel.setMethodCallHandler(this)
    wwapi = WWAPIFactory.createWWAPI(flutterPluginBinding.applicationContext)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "registerApp") {
      val args = call.arguments as Map<String, Any>
      val schema = args["schema"] as String
      val registered = wwapi.registerApp(schema)
      result.success(registered)
    } else if (call.method == "isWWAppInstalled") {
      result.success(wwapi.isWWAppInstalled)
    } else {
      result.notImplemented()
    }
  }
}
