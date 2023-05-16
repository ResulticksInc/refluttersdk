import 'package:flutter_test/flutter_test.dart';
import 'package:refluttersdk/refluttersdk.dart';
import 'package:refluttersdk/refluttersdk_platform_interface.dart';
import 'package:refluttersdk/refluttersdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRefluttersdkPlatform
    with MockPlatformInterfaceMixin
    implements RefluttersdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void addNewNotification(String title,String body) {
    // TODO: implement addNewNotification
  }

  @override
  appConversion() {
    // TODO: implement appConversion
    throw UnimplementedError();
  }

  @override
  appConversionWithData(Map appConvertionData) {
    // TODO: implement appConversionWithData
    throw UnimplementedError();
  }

  @override
  customEvent(String event) {
    // TODO: implement customEvent
    throw UnimplementedError();
  }

  @override
  void customEventWithData(Map eventData) {
    // TODO: implement customEventWithData
  }

  @override
  deepLinkData(type) {
    // TODO: implement deepLinkData
    throw UnimplementedError();
  }

  @override
  deleteNotificationByCampaignId(String campaignId) {
    // TODO: implement deleteNotificationByCampaignId
    throw UnimplementedError();
  }

  @override
  formDataCapture(Map formData) {
    // TODO: implement formDataCapture
    throw UnimplementedError();
  }

  @override
  Future getNotificationList() {
    // TODO: implement getNotificationList
    throw UnimplementedError();
  }

  @override
  Future<int?> getReadNotificationCount() {
    // TODO: implement getReadNotificationCount
    throw UnimplementedError();
  }

  @override
  Future<int?> getUnReadNotificationCount() {
    // TODO: implement getUnReadNotificationCount
    throw UnimplementedError();
  }

  @override
  void listener(NotificationCallback channel) {
    // TODO: implement listener
  }

  @override
  locationUpdate(double lat, double lang) {
    // TODO: implement locationUpdate
    throw UnimplementedError();
  }

  @override
  readNotification(String campaignId) {
    // TODO: implement readNotification
    throw UnimplementedError();
  }

  @override
  screentracking(String screenName) {
    // TODO: implement screentracking
    throw UnimplementedError();
  }

  @override
  sdkRegisteration(Map userData) {
    // TODO: implement sdkRegisteration
    throw UnimplementedError();
  }

  @override
  unReadNotification(String campaignId) {
    // TODO: implement unReadNotification
    throw UnimplementedError();
  }

  @override
  updatePushToken(String token) {
    // TODO: implement updatePushToken
    throw UnimplementedError();
  }

  @override
  void userLogout() {
    // TODO: implement userLogout
  }
}

void main() {
  final RefluttersdkPlatform initialPlatform = RefluttersdkPlatform.instance;

  test('$MethodChannelRefluttersdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRefluttersdk>());
  });

  test('getPlatformVersion', () async {
    Refluttersdk refluttersdkPlugin = Refluttersdk();
    MockRefluttersdkPlatform fakePlatform = MockRefluttersdkPlatform();
    RefluttersdkPlatform.instance = fakePlatform;

   // expect(await refluttersdkPlugin.getPlatformVersion(), '42');
  });
}
