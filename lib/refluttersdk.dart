
import 'refluttersdk_platform_interface.dart';

class Refluttersdk {
  Future<String?> getPlatformVersion() {
    return RefluttersdkPlatform.instance.getPlatformVersion();
  }
  void locationUpdate(double lat, double lang) {
    RefluttersdkPlatform.instance.locationUpdate(lat, lang);
  }
  void addNewNotification(String notificationTitle, String notificationBody) {
    RefluttersdkPlatform.instance.addNewNotification(
        notificationTitle, notificationBody);
  }
  void onTrackEvent(String content) {
    RefluttersdkPlatform.instance.onTrackEvent(content);
  }
  void onTrackEventWithData(String jsonString, String data) {
    RefluttersdkPlatform.instance.onTrackEventWithData(jsonString,data);
  }
  void deleteNotificationByCampaignId(String cid) {
    RefluttersdkPlatform.instance.deleteNotificationByCampaignId(cid);
  }
  void readNotification(String cid) {
    RefluttersdkPlatform.instance.readNotification(cid);
  }
  void appConversionTracking() {
    RefluttersdkPlatform.instance.appConversionTracking();
  }
  void appConversionTrackingWithData(String appConvertionData) {
    RefluttersdkPlatform.instance.appConversionTrackingWithData(appConvertionData);
  }
  void formDataCapture(String formData) {
    RefluttersdkPlatform.instance.formDataCapture(formData);
  }
  Future<int?>  getReadNotificationCount()async {
    var r_Ncount= RefluttersdkPlatform.instance.readNotificationCount();
    return r_Ncount;
  }
  Future <int?> getUnReadNotificationCount()async {
    var un_Ncount= await RefluttersdkPlatform.instance.unReadNotificationCount();
    return un_Ncount;
  }
  void updatePushToken(String token) {
    RefluttersdkPlatform.instance.updatePushToken(token);
  }
  void onDeviceUserRegister(String userData) {
    RefluttersdkPlatform.instance.onDeviceUserRegister(userData);
  }
  void deepLinkData () {
    RefluttersdkPlatform.instance.deepLinkData();

  }
  void unReadNotification(String cid) {
    RefluttersdkPlatform.instance.unReadNotification(cid);
  }


  Future<dynamic> getNotification()async{
    var nList = await RefluttersdkPlatform.instance.getNotification();
    return nList;
  }

  void screentracking(String screenName){
    RefluttersdkPlatform.instance.screentracking(screenName);
  }
  qrlink(String myLink){
    RefluttersdkPlatform.instance.qrlink(myLink);
  }
  notificationCTAClicked(String camplaignId,String actionId){
    RefluttersdkPlatform.instance.notificationCTAClicked(camplaignId,actionId);
  }
  getCampaiginData(){
    RefluttersdkPlatform.instance.getCampaignData();
  }
}
