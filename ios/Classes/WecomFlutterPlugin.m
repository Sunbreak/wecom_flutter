#import "WecomFlutterPlugin.h"
#if __has_include(<wecom_flutter/wecom_flutter-Swift.h>)
#import <wecom_flutter/wecom_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "wecom_flutter-Swift.h"
#endif

@implementation WecomFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWecomFlutterPlugin registerWithRegistrar:registrar];
}
@end
