import Flutter
import UIKit
import Foundation
import REIOSSDK

public class RefluttersdkPlugin: NSObject, FlutterPlugin,REiosSmartLinkReceiver,REiosNotificationReceiver {
    static var reRegister: FlutterPluginRegistrar?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
      reRegister = registrar
    let channel = FlutterMethodChannel(name: "refluttersdk", binaryMessenger: registrar.messenger())
    let instance = RefluttersdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
   @objc
    public func reSdk(with appId: String){
        REiosHandler.smartLinkDelegate = self
        REiosHandler.notificationDelegate = self
        REiosHandler.initSdk(withAppId: appId, notificationCategory: []) { status in
            print("ReSDK successfully init")
        } failure: { message in
            print("ReSDK init failure \(message)")
        }

    }
    @objc
    public func initWithSDK(appId:String) {
        REiosHandler.smartLinkDelegate = self
        REiosHandler.notificationDelegate = self
        REiosHandler.initSdk(withAppId: appId, notificationCategory: []) { status in
            print("ReSDK successfully init")
        } failure: { message in
            print("ReSDK init failure \(message)")
        }
    }
    public func didReceiveSmartLink(data: [String : Any]) {
        if let _register = RefluttersdkPlugin.reRegister {
            let channel = FlutterMethodChannel(name: "refluttersdk", binaryMessenger: _register.messenger())
            channel.invokeMethod("didReceiveSmartLink", arguments: data.json)
        }


    }

    public func didReceiveResponse(data: [String : Any]) {
        if let _register = RefluttersdkPlugin.reRegister {
            let channel = FlutterMethodChannel(name: "refluttersdk", binaryMessenger: _register.messenger())
            channel.invokeMethod("didReceiveResponse", arguments: data.json)
        }
    }

    @objc
    public static func setForegroundNotification(notification: UNNotification, completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        REiosHandler.setForegroundNotification(notification: notification) { handler in
            completionHandler(handler)
        }
    }
    @objc
    public static func didReceiveRemoteNotification(userInfo: [String : Any]){
        REiosHandler.setCustomNotification(userInfo: userInfo)
    }
    @objc
    public static func didReceive(response: UNNotificationResponse){
        REiosHandler.setNotificationAction(response: response)
    }
    @objc
    public static func open(url: URL) {
        REiosHandler.handleOpenlink(url: url) { returnData in
            if let _register = RefluttersdkPlugin.reRegister {
                let channel = FlutterMethodChannel(name: "refluttersdk", binaryMessenger: _register.messenger())
                channel.invokeMethod("didReceiveDeeplinkdata", arguments: returnData)
            }
        } failureHandler: { error in

        }

    }
    @objc
    public static func handleDynamicLink(userActivity: NSUserActivity, successHandler: @escaping (_ returnData: String) -> (Void), failureHandler: @escaping (_ error: String) -> (Void)) {
        REiosHandler.handleDynamicLink(userActivity: userActivity) { returnData in
            if let _register = RefluttersdkPlugin.reRegister {
                let channel = FlutterMethodChannel(name: "refluttersdk", binaryMessenger: _register.messenger())
                channel.invokeMethod("didReceiveDeeplinkdata", arguments: returnData)
            }
            successHandler(returnData)
        } failureHandler: { error in
            failureHandler(error)
        }
 }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    //result("iOS " + UIDevice.current.systemVersion)
    switch(call.method){
      case "sdkRegisteration":
                if let dict = call.arguments as? [String: Any] {
                print(dict)
                REiosHandler.sdkRegistrationWith(params: dict, success: { (status) in
                        print("SDK registration success with status \(status)")
                    }) { (message) in
                        print("SDK registration failed with error \(message)")
                    }
                }
          break;
      case "updatePushToken":
          if let _token = call.arguments as? String {
              REiosHandler.updatePushToken(token: _token)
          }
          break;
      case "locationUpdate":
          if let locationDict = call.arguments as? [String:Any] {
              if let lat = locationDict["lat"] as? Double,let long = locationDict["lang"] as? Double {
                REiosHandler.updateLocation(lat: lat, long: long);
            }
          }
          break;
      case "readNotification":
            if let campaignId = call.arguments as? String {
                REiosHandler.readNotification(campaignId: campaignId) { (count) in
                    result(count)
                }
            }
          break;

      case "unReadNotification":
            if let campaignId = call.arguments as? String {
                REiosHandler.unReadNotification(campaignId: campaignId) { (count) in
                            result(count)
                  }
             }
          break
      case "getNotificationList":
          var note: [[String: Any]] = []
          for dict in REiosHandler.getNotificationList() {
              if let value = dict as? [String: Any] {
                  note.append(value)
              }
            }
        result(note.json)
        break
      case "getReadNotificationCount":
          REiosHandler.getReadNotificationCount { count in
              result(count)
          }
          break
      case "getUnReadNotificationCount":
          REiosHandler.getUnReadNotificationCount { count in
              result(count)
          }
          break
      case "deleteNotificationByCampaignId":
          if let campaignId = call.arguments as? String {
              REiosHandler.deleteNotificationByCampaignId(campaignId: campaignId) { (list) in result(list)
                }
          }
          break
      case "formDataCapture":
          if let dict = call.arguments as? [String: Any] {
              REiosHandler.formDataCapture(dict: dict)
          }
          break
      case "customEvent":
          if let params = call.arguments as? String,params.count > 0 {
              REiosHandler.addCustomEvent(params)
          }
          break;
      case "customEventWithData":
          if let params = call.arguments as? [String: Any] {
              guard let name = params["name"] as? String else {return}
              if let dict = params["data"] as? [String: Any] {
                    REiosHandler.addCustomEvent(name: name, data: dict)
                }
            }
          break;
      case "appConversion":
            REiosHandler.appConversionTracking()
          break;
      case "appConversionWithData":
          if let params = call.arguments as? [String: Any] {
              REiosHandler.appConversionTrackingWith(dict: params)
          }
          break;
      case "screenTracking":
        if let screenName = call.arguments as? String {
            REiosHandler.setScreenName(screenName: screenName)
        }


      default:
          print("Not implemented")
      }
  }
}

extension Array {

    var json: String? {

        let invalidJson: String? = nil

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
extension Dictionary {

    var json: String? {

        let invalidJson: String? = nil

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}
