import 'package:flutter/services.dart';

class WecomFlutter {
  static const _methodChannel = MethodChannel('wecom_flutter');

  static Future<bool> registerApp({
    required String schema,
  }) async {
    bool registered = await _methodChannel.invokeMethod('registerApp', {
      'schema': schema
    });
    return registered;
  }
}
