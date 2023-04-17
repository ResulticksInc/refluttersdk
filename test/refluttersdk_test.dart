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

    expect(await refluttersdkPlugin.getPlatformVersion(), '42');
  });
}
