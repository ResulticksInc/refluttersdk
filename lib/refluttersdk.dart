
import 'refluttersdk_platform_interface.dart';

class Refluttersdk {

  void locationUpdate(double lat, double lang) {
    RefluttersdkPlatform.instance.locationUpdate(lat, lang);
  }
  void addNewNotification(String notificationTitle, String notificationBody) {
    RefluttersdkPlatform.instance.addNewNotification(notificationTitle, notificationBody);
  }
  void customEvent(String event) {
    RefluttersdkPlatform.instance.customEvent(event);
  }
  void customEventWithData(Map eventData, String event) {
    RefluttersdkPlatform.instance.customEventWithData(eventData,event);
  }
  void deleteNotificationByCampaignId(String campaignId) {
    RefluttersdkPlatform.instance.deleteNotificationByCampaignId(campaignId);
  }
  void readNotification(String campaignId) {
    RefluttersdkPlatform.instance.readNotification(campaignId);
  }
  void appConversion() {
    RefluttersdkPlatform.instance.appConversion();
  }
  void appConversionWithData(Map appConvertionData) {
    RefluttersdkPlatform.instance.appConversionWithData(appConvertionData);
  }
  void formDataCapture(Map formData) {
    RefluttersdkPlatform.instance.formDataCapture(formData);
  }
  Future<int?>  getReadNotificationCount()async {
    var r_Ncount= RefluttersdkPlatform.instance.getReadNotificationCount();
    return r_Ncount;
  }
  Future <int?> getUnReadNotificationCount()async {
    var un_Ncount= await RefluttersdkPlatform.instance.getUnReadNotificationCount();
    return un_Ncount;
  }
  void updatePushToken(String token) {
    RefluttersdkPlatform.instance.updatePushToken(token);
  }
  void sdkRegisteration(Map userData) {
    RefluttersdkPlatform.instance.sdkRegisteration(userData);
  }
  void deepLinkData () {
    RefluttersdkPlatform.instance.deepLinkData();
  }
  void unReadNotification(String campaignId) {
    RefluttersdkPlatform.instance.unReadNotification(campaignId);
  }


  Future<dynamic> getNotificationList() async{
    var nList = await RefluttersdkPlatform.instance.getNotificationList();
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
