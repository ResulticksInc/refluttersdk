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
-(void)initWithSDK:(NSString *)appId {
    SwiftRefluttersdkPlugin *obj = [[SwiftRefluttersdkPlugin alloc]init];
    [obj reSdkWith:appId];
}
+(void)willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    [SwiftRefluttersdkPlugin setForegroundNotificationWithNotification:notification completionHandler:completionHandler];
}
+(void)didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo{
    [SwiftRefluttersdkPlugin setCustomNotificationWithUserInfo:userInfo];
}
+(void)didReceiveNotificationResponse:(UNNotificationResponse *)response {
    [SwiftRefluttersdkPlugin setNotificationActionWithResponse:response];
}
+(void)openURL:(NSURL *)url{
    [SwiftRefluttersdkPlugin openUrlWithUrl:url];
}
+ (void)handleDynamicLinkWithUserActivity:(NSUserActivity *)userActivity
                            successHandler:(void (^)(NSString *returnData))successHandler
                           failureHandler:(void (^)(NSString *error))failureHandler{
    [SwiftRefluttersdkPlugin handleDynamicLinkWithUserActivity:userActivity successHandler:^(NSString * data) {
        successHandler(data);
    } failureHandler:^(NSString * err) {
        failureHandler(err);
    }];
    
}
@end
