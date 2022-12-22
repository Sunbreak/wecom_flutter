#if __has_include(<wecom_flutter/WWKApi.h>)
#import <wecom_flutter/WWKApi.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "WWKApi.h"
#endif

#if __has_include(<wecom_flutter/WWKApiObject.h>)
#import <wecom_flutter/WWKApiObject.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "WWKApiObject.h"
#endif