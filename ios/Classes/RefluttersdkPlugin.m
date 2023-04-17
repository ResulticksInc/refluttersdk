#import "RefluttersdkPlugin.h"
#if __has_include(<refluttersdk/refluttersdk-Swift.h>)
#import <refluttersdk/refluttersdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "refluttersdk-Swift.h"
#endif

@implementation RefluttersdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRefluttersdkPlugin registerWithRegistrar:registrar];
}
@end
