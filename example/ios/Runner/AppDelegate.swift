import UIKit
import Flutter
import refluttersdk

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
     // RefluttersdkPlugin.testMethod("Ram")
      
      RefluttersdkPlugin.initWithSDK("b78db6b3-9462-4132-a4d3-894db10b3782")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
