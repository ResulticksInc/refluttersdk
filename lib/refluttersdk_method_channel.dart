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
  void addNewNotification(String notificationTitle, String notificationBody) {
    methodChannel.invokeMapMethod('addNewNotification',{'title': notificationTitle,'body':notificationBody});
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
    final notifyCount=await methodChannel.invokeMethod<int>('getReadNotificationCount');
    return notifyCount;
  }

  @override
  void unReadNotification(String campaignId) {
    methodChannel.invokeMethod('unReadNotification',campaignId);
  }
  @override
  Future <int?> getUnReadNotificationCount() async {
    final ur_nCount= await methodChannel.invokeMethod('getUnReadNotificationCount');
    return ur_nCount;
  }

  @override
  Future<dynamic> getNotificationList() async {
    var nList = await methodChannel.invokeMethod('getNotificationList');
    return nList;
  }
@override
  void screentracking(String screenName) {
  methodChannel.invokeMethod('screenTracking',screenName);
}

  @override
  void qrlink(String myLink){
    methodChannel.invokeMapMethod('qrlink',{"myLink":myLink});
  }
  @override
  void notificationCTAClicked(String camplaignId,String actionId){
    methodChannel.invokeMapMethod('notificationCTAClicked',{"campaignId":camplaignId,"actionId":actionId});
  }
  @override
  void getCampaignData(){
    methodChannel.invokeMethod('getCampaignData');
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
          print("Plugin didReceiveResponse" + call.arguments as String);
          callback(call.arguments as String);
        }
        break;
      case "didReceiveSmartLink":
        {
          print("Plugin didReceiveSmartLink" + call.arguments as String);
          callback(call.arguments as String);
        }
        break;
      case "didReceiveDeeplinkdata":
        {
          print("Plugin didReceiveDeeplinkdata" + call.arguments as String);
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
