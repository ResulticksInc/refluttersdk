import 'refluttersdk_platform_interface.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'refluttersdkweb.dart';


typedef void NotificationCallback(String data);


class Refluttersdk {


  void locationUpdate(double lat, double lang) {
      if (kIsWeb) {
        ReFlutterWebSDK.userLocation(lat, lang);
      } else {
        RefluttersdkPlatform.instance.locationUpdate(lat, lang);
      }
    }

    void customEvent(String event) {
      if (kIsWeb) {
        ReFlutterWebSDK.customEvent(event);
      } else {
        RefluttersdkPlatform.instance.customEvent(event);
      }
    }


    void customEventWithData(Map eventData) {
      if (kIsWeb) {
        ReFlutterWebSDK.customEventWithData(eventData);
      } else {
        RefluttersdkPlatform.instance.customEventWithData(eventData);
      }
    }

    void deleteNotificationByCampaignId(String campaignId) {
      RefluttersdkPlatform.instance.deleteNotificationByCampaignId(campaignId);
    }

    void readNotification(String campaignId) {
      RefluttersdkPlatform.instance.readNotification(campaignId);
    }

    void appConversion() {
      if (kIsWeb) {
        ReFlutterWebSDK.webConversationTracking();
      } else {
        RefluttersdkPlatform.instance.appConversion();
      }
    }

    void appConversionWithData(Map appConvertionData) {
        RefluttersdkPlatform.instance.appConversionWithData(appConvertionData);
    }

    void formDataCapture(Map formData) {
      RefluttersdkPlatform.instance.formDataCapture(formData);
    }

    Future<int?> getReadNotificationCount() async {
      var readNotificationCount = RefluttersdkPlatform.instance
          .getReadNotificationCount();
      return readNotificationCount;
    }

    Future<int?> getUnReadNotificationCount() async {
      var unReadNotificationCount =
      await RefluttersdkPlatform.instance.getUnReadNotificationCount();
      return unReadNotificationCount;
    }

    void updatePushToken(String token) {
      if (kIsWeb) {
        ReFlutterWebSDK.updatePushToken(token);
      } else {
        RefluttersdkPlatform.instance.updatePushToken(token);
      }

    }
    void addNewNotification(String notificationTitle, String notificationBody) {
      RefluttersdkPlatform.instance.addNewNotification(
          notificationTitle, notificationBody);
    }

    void sdkRegisteration(Map userData) {
      if (kIsWeb) {
        ReFlutterWebSDK.userRegister(userData);
      } else {
        RefluttersdkPlatform.instance.sdkRegisteration(userData);
      }
    }

    getURLData(String type) {
      RefluttersdkPlatform.instance.deepLinkData(type);
    }

    void unReadNotification(String campaignId) {
      RefluttersdkPlatform.instance.unReadNotification(campaignId);
    }

    Future<dynamic> getNotificationList() async {
      var notificationList = await RefluttersdkPlatform.instance
          .getNotificationList();
      return notificationList;
    }

    void screentracking(String screenName) {
      RefluttersdkPlatform.instance.screentracking(screenName);
    }

    listener(NotificationCallback channel) {
      RefluttersdkPlatform.instance.listener(channel);
    }

    initWebSDK(String fcmPath) {
      if (kIsWeb) {
        ReFlutterWebSDK.initWebSDK(fcmPath);
      }
    }
  void userLogout() {
    if (kIsWeb) {
      ReFlutterWebSDK.userLogout();
    }
  }
  }

