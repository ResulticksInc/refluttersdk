import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:refluttersdk/refluttersdk.dart';
import 'refluttersdk_platform_interface.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';


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

  bool _initialURILinkHandled = false;
  StreamSubscription? _streamSubscription;
  var flag = false;


  Future<void> _initURIHandler() async {
    // 1
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      try {
        // 3
        final initialURI = await getInitialUri();
        // 4

        if (initialURI != null) {
          flag = true;
          deepLinkData("URL"); 
        }else {
            deepLinkData("Activity"); 
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
        flag = true;
        if (uri != null) {
           deepLinkData("URL");
        }else {
           deepLinkData("Activity");
        }
      }, onError: (Object err) {
         deepLinkData("Activity");
      });
    }
  }

  @override
  void listener(NotificationCallback channel) {
    _initURIHandler();
    _incomingLinkHandler();
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
          print("Mismatch occurred :: Default executed");
        }
        break;
    }
  }

}
