import 'package:flutter_test/flutter_test.dart';
import 'package:wecom_flutter/wecom_flutter.dart';
import 'package:wecom_flutter/wecom_flutter_platform_interface.dart';
import 'package:wecom_flutter/wecom_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWecomFlutterPlatform
    with MockPlatformInterfaceMixin
    implements WecomFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WecomFlutterPlatform initialPlatform = WecomFlutterPlatform.instance;

  test('$MethodChannelWecomFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWecomFlutter>());
  });

  test('getPlatformVersion', () async {
    WecomFlutter wecomFlutterPlugin = WecomFlutter();
    MockWecomFlutterPlatform fakePlatform = MockWecomFlutterPlatform();
    WecomFlutterPlatform.instance = fakePlatform;

    expect(await wecomFlutterPlugin.getPlatformVersion(), '42');
  });
}
