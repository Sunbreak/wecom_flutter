import 'package:flutter/services.dart';

class WecomFlutter {
  static const _methodChannel = MethodChannel('wecom_flutter');

  Future<String?> getPlatformVersion() async {
    final version = await _methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
