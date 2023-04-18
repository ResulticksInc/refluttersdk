#import <Flutter/Flutter.h>

@interface RefluttersdkPlugin : NSObject<FlutterPlugin>
+(void)initWithSDK:(NSString *)appId;
+(void)testMethod:(NSString *)name;
@end
