import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:refluttersdk/refluttersdk.dart';

import 'refluttersdk_method_channel.dart';

abstract class RefluttersdkPlatform extends PlatformInterface {
  /// Constructs a RefluttersdkPlatform.

  RefluttersdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static RefluttersdkPlatform _instance = MethodChannelRefluttersdk();

  /// The default instance of [RefluttersdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelRefluttersdk].
  static RefluttersdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RefluttersdkPlatform] when
  /// they register themselves.
  static set instance(RefluttersdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

   locationUpdate(double lat, double lang) {
    throw UnimplementedError('locationUpdate() has not been implemented');
  }

   addNewNotification(String notificationTitle, String notificationBody){
    throw UnimplementedError('newNotification() has not been implemented');
  }

   customEvent(String event) {
    throw UnimplementedError('customEvent() has not been implemented');
  }

  void customEventWithData(Map eventData) {
    throw UnimplementedError('customEventWithData() has not been implemented.');
  }

   deleteNotificationByCampaignId(String campaignId) {
    throw UnimplementedError('deleteNotificationByCampaignId() has not been implemented');
  }
   readNotification(String campaignId) {
    throw UnimplementedError('readNotification() has not been implemented');
  }

   appConversion() {
    throw UnimplementedError('appConversion() has not been implemented');
  }
   appConversionWithData(Map appConvertionData) {
    throw UnimplementedError('appConversionWithData() has not been implemented');
  }

  formDataCapture(Map formData) {
    throw UnimplementedError('formDataCapture() has not been implemented');
  }

  Future<int?>getReadNotificationCount() {
    throw UnimplementedError('getReadNotificationCount() has not been implemented');
  }

   updatePushToken(String token) {
    throw UnimplementedError('updatePushToken() has not been implemented');
  }

   sdkRegisteration(Map userData) {
    throw UnimplementedError('sdkRegisteration() has not been implemented');
  }

   deepLinkData(type) {
    throw UnimplementedError('deepLinkData() has not been implemented');
  }

   unReadNotification(String campaignId) {
    throw UnimplementedError('unReadNotification() has not been implemented');
  }
  Future <int?> getUnReadNotificationCount() {
    throw UnimplementedError('getUnReadNotification() has not been implemented');
  }


  Future<dynamic>getNotificationList() {
    throw UnimplementedError('getNotificationList() has not been implemented.');
  }

   screentracking(String screenName) {
    throw UnimplementedError('screentracking() has not been implemented.');
  }

   qrlink(String myLink) {
    throw UnimplementedError('qrlink() has not been implemented.');
  }

   notificationCTAClicked(String camplaignId, String actionId) {
    throw UnimplementedError('notificationCTAClicked() has not been implemented.');
  }

   getCampaignData() {
    throw UnimplementedError('getCampaignData() has not been implemented');
  }

  void listener(NotificationCallback channel){
    throw UnimplementedError('setMethodChannel() has not been implemented');
  }
}
