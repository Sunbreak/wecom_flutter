
import 'wecom_flutter_platform_interface.dart';

class WecomFlutter {
  Future<String?> getPlatformVersion() {
    return WecomFlutterPlatform.instance.getPlatformVersion();
  }
}
