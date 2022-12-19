import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wecom_flutter/wecom_flutter_method_channel.dart';

void main() {
  MethodChannelWecomFlutter platform = MethodChannelWecomFlutter();
  const MethodChannel channel = MethodChannel('wecom_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
