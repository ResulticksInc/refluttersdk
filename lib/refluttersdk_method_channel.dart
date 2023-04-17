import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'refluttersdk_platform_interface.dart';

/// An implementation of [RefluttersdkPlatform] that uses method channels.
class MethodChannelRefluttersdk extends RefluttersdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('refluttersdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  locationUpdate(double lat, double lang) {
    methodChannel.invokeMapMethod('locationUpdate', {'lat': lat, 'lang': lang});
  }

  @override
  addNewNotification(String notificationTitle, String notificationBody) {
    methodChannel.invokeMapMethod('addNewNotification',{'title': notificationTitle,'body':notificationBody});
  }
  @override
  onTrackEvent(String content) {
    methodChannel.invokeMapMethod('customEvent',{'string': content});
  }
  @override
  void onTrackEventWithData(String jsonString, String data) {
    methodChannel.invokeMapMethod('customEventWithData',{"eventData":jsonString,"event":data});
  }
  @override
  deleteNotificationByCampaignId(content) {
    methodChannel.invokeMapMethod('deleteNotificationByCampaignId',{'cid':content});
  }
  @override
  readNotification(content) {
    methodChannel.invokeMapMethod('readNotification',{'cid':content});
  }
  @override
  appConversionTracking() {
    methodChannel.invokeMapMethod('appConversion');
  }
  @override
  appConversionTrackingWithData(String appConvertionData) {
    methodChannel.invokeMapMethod('appConversionWithData',{'appConvertionData':appConvertionData});
  }

  @override
  formDataCapture(String formData) {
    methodChannel.invokeMapMethod('formDataCapture',{'formData':formData});
  }

  @override
  updatePushToken(String regToken) {
    methodChannel.invokeMapMethod('updatePushToken',{'regToken':regToken});
  }
  @override
  onDeviceUserRegister(String userData) {
    methodChannel.invokeMapMethod('sdkRegisteration',{'userData':userData});
  }
  @override
  void deepLinkData() {
    methodChannel.invokeMapMethod('deepLinkData');
  }
  @override
  Future<int?> readNotificationCount() async {
    final notifyCount=await methodChannel.invokeMethod<int>('getReadNotificationCount');
    return notifyCount;
  }
  @override
  unReadNotification(String cid) {
    methodChannel.invokeMapMethod('unReadNotification',{'cid':cid});
  }
  @override
  Future <int?> unReadNotificationCount() async {
    final ur_nCount= await methodChannel.invokeMethod('getUnReadNotificationCount');
    return ur_nCount;
  }

  @override
  Future<dynamic> getNotification() async {
    var nList = await methodChannel.invokeMethod('getNotificationList');
    return nList;
  }
@override
void screentracking(String screenName) {
  methodChannel.invokeMapMethod('screenTracking',{"screenname":screenName});
}

  @override
  qrlink(String myLink){
    methodChannel.invokeMapMethod('qrlink',{"myLink":myLink});
  }
  @override
  notificationCTAClicked(String camplaignId,String actionId){
    methodChannel.invokeMapMethod('notificationCTAClicked',{"campaignId":camplaignId,"actionId":actionId});
  }
  @override
  getCampaignData(){
    methodChannel.invokeMethod('getCampaignData');
  }


}
