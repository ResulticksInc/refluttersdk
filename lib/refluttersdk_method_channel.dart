import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:refluttersdk/refluttersdk.dart';
import 'refluttersdk_platform_interface.dart';

/// An implementation of [RefluttersdkPlatform] that uses method channels.
class MethodChannelRefluttersdk extends RefluttersdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('refluttersdk');

  @override
  void locationUpdate(double lat, double lang) {
    methodChannel.invokeMapMethod('locationUpdate', {'lat': lat, 'lang': lang});
  }
  @override
  void addNewNotification() {
    methodChannel.invokeMethod('addNotification');
  }
  @override
  void customEvent(String event) {
    methodChannel.invokeMethod('customEvent',event);
  }
  @override
  void customEventWithData(Map eventData) {
    methodChannel.invokeMethod('customEventWithData',eventData);
  }
  @override
  void deleteNotificationByCampaignId(String campaignId) {
    methodChannel.invokeMethod('deleteNotificationByCampaignId',campaignId);
  }
  @override
  void readNotification(String campaignId) {
    methodChannel.invokeMethod('readNotification',campaignId);
  }
  @override
  void appConversion() {
    methodChannel.invokeMethod('appConversion');
  }
  @override
  void appConversionWithData(Map appConvertionData) {
    methodChannel.invokeMethod('appConversionWithData',appConvertionData);
  }

  @override
  void formDataCapture(Map formData) {
    methodChannel.invokeMethod('formDataCapture',formData);
  }

  @override
  void updatePushToken(String regToken) {
    methodChannel.invokeMethod('updatePushToken',regToken);
  }
  @override
  void sdkRegisteration(Map userData) {
    methodChannel.invokeMethod('sdkRegisteration',userData);
  }
  @override
  void deepLinkData(type)  {
    methodChannel.invokeMethod('deepLinkData',type);
  }
  @override
  Future<int?> getReadNotificationCount() async {
    final readNotificationCount=await methodChannel.invokeMethod<int>('getReadNotificationCount');
    return readNotificationCount;
  }

  @override
  void unReadNotification(String campaignId) {
    methodChannel.invokeMethod('unReadNotification',campaignId);
  }
  @override
  Future <int?> getUnReadNotificationCount() async {
    final unReadNotificationCount= await methodChannel.invokeMethod('getUnReadNotificationCount');
    return unReadNotificationCount;
  }

  @override
  Future<dynamic> getNotificationList() async {
    var notificationList = await methodChannel.invokeMethod('getNotificationList');
    return notificationList;
  }
  @override
  void screentracking(String screenName) {
    methodChannel.invokeMethod('screenTracking',screenName);
  }

  @override
  void listener(NotificationCallback channel) {
    methodChannel
        .setMethodCallHandler((call) => _notificationListener(channel, call));
  }

  _notificationListener(NotificationCallback callback, MethodCall call) async {
    switch (call.method) {
      case "didReceiveResponse":
        {
          callback(call.arguments as String);
        }
        break;
      case "didReceiveSmartLink":
        {
          callback(call.arguments as String);
        }
        break;
      case "didReceiveDeeplinkdata":
        {
          callback(call.arguments as String);
        }
        break;
      case "onDeepLinkData":{
        {
          callback(call.arguments as String);
        }
        break;
      }
      case "onInstallDataReceived":{
        callback(call.arguments as String);
      }
      break;

      default:
        {
          print("Default");
        }
        break;
    }
  }

}
