import 'package:flutter/services.dart';

class WecomFlutter {
  static const _methodChannel = MethodChannel('wecom_flutter');

  static Future<bool> registerApp({
    required String schema,
    required String appId,
    required String agentId,
  }) async {
    bool registered = await _methodChannel.invokeMethod('registerApp', {
      'schema': schema,
      'appId': appId,
      'agentId': agentId,
    });
    return registered;
  }

  static Future<bool> isWWAppInstalled() async {
    bool isWWAppInstalled = await _methodChannel.invokeMethod('isWWAppInstalled');
    return isWWAppInstalled;
  }
}
