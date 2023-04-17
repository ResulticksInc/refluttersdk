import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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

  void locationUpdate(double lat, double lang) {
    throw UnimplementedError('locationUpdate() has not been implemented');
  }

  void addNewNotification(String notificationTitle, String notificationBody){
    throw UnimplementedError('newNotification() has not been implemented');
  }

  void onTrackEvent(String content) {
    throw UnimplementedError('onTrackEvent() has not been implemented');
  }

  void onTrackEventWithData(String content, String data) {
    throw UnimplementedError('onTrackEventWithData() has not been implemented.');
  }

  void customEvent(String eventData, String event) {
    throw UnimplementedError('onTrackEventwithData() has not been implemented.');
  }

  void deleteNotificationByCampaignId(content) {
    throw UnimplementedError('deleteNotificationByCampaignId() has not been implemented');
  }
  void readNotification(content) {
    throw UnimplementedError('readNotification() has not been implemented');
  }

  void appConversionTracking() {
    throw UnimplementedError('appConversionTracking() has not been implemented');
  }
  void appConversionTrackingWithData(String appConvertionData) {
    throw UnimplementedError('appConversionTrackingWithData() has not been implemented');
  }


  void formDataCapture(String formData) {
    throw UnimplementedError('formDataCapture() has not been implemented');
  }

  Future<int?>readNotificationCount() {
    throw UnimplementedError('readNotificationCount() has not been implemented');
  }

  void updatePushToken(String token) {
    throw UnimplementedError('updatePushToken() has not been implemented');
  }

  void onDeviceUserRegister(String userData) {
    throw UnimplementedError('onDeviceUserRegister() has not been implemented');
  }

  void deepLinkData() {
    throw UnimplementedError('deepLinkData() has not been implemented');
  }

  void unReadNotification(String cid) {
    throw UnimplementedError('unReadNotification() has not been implemented');
  }
  Future <int?> unReadNotificationCount() {
    throw UnimplementedError('unReadNotification() has not been implemented');
  }


  Future<dynamic>getNotification() {
    throw UnimplementedError('getNotification() has not been implemented.');
  }

  void screentracking(String screenName) {
    throw UnimplementedError('screentracking() has not been implemented.');
  }

  void qrlink(String myLink) {
    throw UnimplementedError('qrlink() has not been implemented.');
  }

  void notificationCTAClicked(String camplaignId, String actionId) {
    throw UnimplementedError('notificationCTAClicked() has not been implemented.');
  }

  void getCampaignData() {
    throw UnimplementedError('getCampaignData() has not been implemented');
  }

}
