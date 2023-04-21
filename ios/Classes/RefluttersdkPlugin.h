#import <Flutter/Flutter.h>

@interface RefluttersdkPlugin : NSObject<FlutterPlugin>
-(void)initWithSDK:(NSString *)appId;
+(void)willPresentNotification:(UNNotification *)notification
        withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler;
+(void)didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo;
+(void)didReceiveNotificationResponse:(UNNotificationResponse *)response;
+(void)openURL:(NSURL *)url;
+ (void)handleDynamicLinkWithUserActivity:(NSUserActivity *)userActivity
                            successHandler:(void (^)(NSString *returnData))successHandler
                           failureHandler:(void (^)(NSString *error))failureHandler;


@end
