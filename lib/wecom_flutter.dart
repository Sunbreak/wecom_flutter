import 'package:flutter/services.dart';

import 'src/models.dart';

export 'src/models.dart';

typedef OnAuthResponse = void Function(Map<String, dynamic> resp);

class WecomFlutter {
  static late final _instance = WecomFlutter._();

  factory WecomFlutter() => _instance;

  final _methodChannel = const MethodChannel('wecom_flutter');

  OnAuthResponse? onAuthResponse;

  WecomFlutter._() {
    _methodChannel.setMethodCallHandler(_handleResponse);
  }

  Future<dynamic> _handleResponse(MethodCall call) async {
    if (call.method == 'onAuthResponse') {
      onAuthResponse?.call({
        'errCode': call.arguments['errCode'],
        'code': call.arguments['code'],
        'state': call.arguments['state'],
      });
    }
  }

  Future<bool> registerApp({
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

  Future<bool> isWWAppInstalled() async {
    bool isWWAppInstalled = await _methodChannel.invokeMethod('isWWAppInstalled');
    return isWWAppInstalled;
  }

  Future<bool> sendWeComAuth({String? state}) async {
    bool sent = await _methodChannel.invokeMethod('sendWeComAuth', {
      'state': state,
    });
    return sent;
  }

  Future<bool> shareToWeCom(WeComShareBaseModel model) async {
    bool sent = await _methodChannel.invokeMethod('shareToWeCom', {
      'type': model.runtimeType.toString(),
      'model': model.toMap(),
    });
    return sent;
  }
}
