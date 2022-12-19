import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wecom_flutter_method_channel.dart';

abstract class WecomFlutterPlatform extends PlatformInterface {
  /// Constructs a WecomFlutterPlatform.
  WecomFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WecomFlutterPlatform _instance = MethodChannelWecomFlutter();

  /// The default instance of [WecomFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWecomFlutter].
  static WecomFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WecomFlutterPlatform] when
  /// they register themselves.
  static set instance(WecomFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
