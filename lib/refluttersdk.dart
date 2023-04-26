import 'refluttersdk_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

typedef void NotificationCallback(String data);


class Refluttersdk {
  void locationUpdate(double lat, double lang) {
    RefluttersdkPlatform.instance.locationUpdate(lat, lang);
  }
  void customEvent(String event) {
    RefluttersdkPlatform.instance.customEvent(event);
  }

  void customEventWithData(Map eventData) {
    RefluttersdkPlatform.instance.customEventWithData(eventData);
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

  Future<int?> getReadNotificationCount() async {
    var readNotificationCount = RefluttersdkPlatform.instance.getReadNotificationCount();
    return readNotificationCount;
  }

  Future<int?> getUnReadNotificationCount() async {
    var unReadNotificationCount =
        await RefluttersdkPlatform.instance.getUnReadNotificationCount();
    return unReadNotificationCount;
  }

  void updatePushToken(String token) {
    RefluttersdkPlatform.instance.updatePushToken(token);
  }
  void addNewNotification() {
    RefluttersdkPlatform.instance
        .addNewNotification();
  }

  void sdkRegisteration(Map userData) {
    RefluttersdkPlatform.instance.sdkRegisteration(userData);
  }
  bool _initialURILinkHandled = false;

  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;
  StreamSubscription? _streamSubscription;

  Future<void> _initURIHandler() async {
    // 1
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      try {
        // 3
        final initialURI = await getInitialUri();
        // 4
        if (initialURI != null) {
          getURLData("URL");
        }
      } on PlatformException {
        // 5
      } on FormatException catch (err) {
        // 6
      }
    }
  }

  void _incomingLinkHandler() {
    if (!kIsWeb) {
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        getURLData("URL");
      }, onError: (Object err) {});
    }
  }



  getURLData(String type) {
    RefluttersdkPlatform.instance.deepLinkData(type);
  }

  void deepLinkData() {
    _initURIHandler();
    _incomingLinkHandler();
    getURLData("Activity");
  }

  void unReadNotification(String campaignId) {
    RefluttersdkPlatform.instance.unReadNotification(campaignId);
  }

  Future<dynamic> getNotificationList() async {
    var notificationList = await RefluttersdkPlatform.instance.getNotificationList();
    return notificationList;
  }

  void screentracking(String screenName) {
    RefluttersdkPlatform.instance.screentracking(screenName);
  }


  listener(NotificationCallback channel){
    RefluttersdkPlatform.instance.listener(channel);
  }

}
