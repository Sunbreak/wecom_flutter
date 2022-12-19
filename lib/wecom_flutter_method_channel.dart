import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wecom_flutter_platform_interface.dart';

/// An implementation of [WecomFlutterPlatform] that uses method channels.
class MethodChannelWecomFlutter extends WecomFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wecom_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
