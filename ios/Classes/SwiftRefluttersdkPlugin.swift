import Flutter
import UIKit
import REIOSSDK

public class SwiftRefluttersdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "refluttersdk", binaryMessenger: registrar.messenger())
    let instance = SwiftRefluttersdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
    @objc
    public static func reSdk(with appId: String){
        REiosHandler.initSdk(withAppId: appId, notificationCategory: []) { status in
            print("ReSDK successfully init")
        } failure: { message in
            print("ReSDK init failure \(message)")
        }

    }
    @objc
    public static func testMethod(with appId:String){
        print(appId)
    }
   
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
   // result("iOS " + UIDevice.current.systemVersion)
      switch(call.method){
      case "sdkRegistration":
                if let dict = call.arguments as? [String: Any] {
                print(dict)
                REiosHandler.sdkRegistrationWith(params: dict, success: { (status) in
                        print("SDK registration success with status \(status)")
                    }) { (message) in
                                 print("SDK registration failed with error \(message)")
                    }
                }
          break;
          
      default:
          print("Not implemented")
      }
  }
}
