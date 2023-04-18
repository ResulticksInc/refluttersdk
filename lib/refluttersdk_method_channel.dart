import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'refluttersdk_platform_interface.dart';

/// An implementation of [RefluttersdkPlatform] that uses method channels.
class MethodChannelRefluttersdk extends RefluttersdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('refluttersdk');


  @override
  locationUpdate(double lat, double lang) {
    methodChannel.invokeMapMethod('locationUpdate', {'lat': lat, 'lang': lang});
  }

  @override
  addNewNotification(String notificationTitle, String notificationBody) {
    methodChannel.invokeMapMethod('addNewNotification',{'title': notificationTitle,'body':notificationBody});
  }

  @override
  customEvent(String event) {
    methodChannel.invokeMethod('customEvent',event);
  }

  @override
  void customEventWithData(Map eventData, String event) {
    methodChannel.invokeMapMethod('customEventWithData',{"eventData":eventData,"event":event});
  }
  @override
  deleteNotificationByCampaignId(String campaignId) {
    methodChannel.invokeMethod('deleteNotificationByCampaignId',campaignId);
  }
  @override
  readNotification(String campaignId) {
    methodChannel.invokeMapMethod('readNotification',campaignId);
  }
  @override
  appConversion() {
    methodChannel.invokeMapMethod('appConversion');
  }
  @override
  appConversionWithData(Map appConvertionData) {
    methodChannel.invokeMethod('appConversionWithData',appConvertionData);
  }

  @override
  formDataCapture(Map formData) {
    methodChannel.invokeMethod('formDataCapture',formData);
  }

  @override
  updatePushToken(String regToken) {
    methodChannel.invokeMapMethod('updatePushToken',regToken);
  }
  @override
  sdkRegisteration(Map userData) {
    methodChannel.invokeMethod('sdkRegisteration',userData);
  }
  @override
  void deepLinkData() {
    methodChannel.invokeMapMethod('deepLinkData');
  }
  @override
  Future<int?> getReadNotificationCount() async {
    final notifyCount=await methodChannel.invokeMethod<int>('getReadNotificationCount');
    return notifyCount;
  }

  @override
  unReadNotification(String campaignId) {
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
