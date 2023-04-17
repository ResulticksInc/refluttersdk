import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:refluttersdk/refluttersdk.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 // Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _refluttersdkPlugin = Refluttersdk();
      String token = "ezyY7vF9TSqiwA3wxwJmYC:APA91bENxHnr2Z2XFHRpbu7GVJklVnDjs7phmEh2M4YNcxxxrPNRw1wtlvwAkGES_uEH8-wRAck30oBkvOwlZ0fJOyVYbcuOAaiOlHGwA9LTLxFnT5iAPAQEGN2LIgfyh6Ax9Iw5Kcf7";
  int notificationCount = 0,
      _counter = 0;
  late String cid;
  late String nList;
  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    initPlatformState();
   // Firebase.initializeApp();
  }

  passLocation() {
    double lat = 13.0827;
    double lang = 80.2707;
    _refluttersdkPlugin.locationUpdate(lat, lang);
  }

  newNotification() {
    var notificationTitle = "sample Title";
    var notificationBody = "sample Body";
    _refluttersdkPlugin.addNewNotification(
        notificationTitle, notificationBody);
  }

  ontrackEvent() {
    var content = "On Track Event called!!!";
    _refluttersdkPlugin.onTrackEvent(content);
  }

  deleteNotificationByCampaignid() {
    setCidState();
    _refluttersdkPlugin.deleteNotificationByCampaignId(cid);
  }

  setCidState() {
    setState(() {
      cid ="k2S||FaV|vV|T_tX7N6|1003123|Bulk|20221115060533";
    });
  }

  readnotification() {
    setCidState();
    _refluttersdkPlugin.readNotification(cid);
  }

  unreadNotification() {
    setCidState();
    _refluttersdkPlugin.unReadNotification(cid);
  }

  appconversionTracking() {
    _refluttersdkPlugin.appConversionTracking();
  }

  formdataCapture() {
    Map param = {
      "Name": "vishwa",
      "EmailID": "abc@gmail.com",
      "MobileNo": 9329222922,
      "Gender": "Male",
      "formid": 101, // required
      "apikey": "api_key_b78db6rb3-9462-4132-a4d3-894db10b3782",
      "City": "Chennai" // required
    };
    String formData = jsonEncode(param);
    _refluttersdkPlugin.formDataCapture(formData);
  }

  onTrackEventwithData() {
    var data = {
      "name": "payment",
      "data": {"id": "2d43", "price": "477"}
    };
    String eventData = jsonEncode(data);
    _refluttersdkPlugin.onTrackEventWithData(eventData, "Purchase");
  }

  updatepushToken() {
    _refluttersdkPlugin.updatePushToken(token);
  }
  ondeviceRegister() {

    Map param = {
      "userUniqueId":"123",
      "name": "vishwa",
      "age":"23",
      "email": "abc@gmail.com",
      "phone": "12334455",
      "gender": "Male",
      "profileUrl":"",
      "dob":"23/12/2010",
      "education":"BE",
      "employed":"true",
      "married":"false",
      "deviceToken":token,
      "storeId":"2334"
    };
    String userData = jsonEncode(param);
    _refluttersdkPlugin.onDeviceUserRegister(userData);
  }


  getdeepLinkData() {
    _refluttersdkPlugin.deepLinkData();
  }
  Future<int?> readnotificationCount() async {
    var rnCount = await _refluttersdkPlugin.getReadNotificationCount()!;
    setState(() {
      notificationCount = rnCount!;
    });
    if (kDebugMode) {
      print("readNotificationCount::$rnCount");
    }
    return null;
  }
subscribeForNotification() async {
 // await FirebaseMessaging.instance.subscribeToTopic("resul");
}
unSubscribeFromNotification() {
 // FirebaseMessaging.instance.unsubscribeFromTopic("resul");
}



  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _refluttersdkPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: SingleChildScrollView(
              child:ConstrainedBox(
                  constraints: BoxConstraints(),
                  child:Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () { //
                            ondeviceRegister();
                          }, child: Text("On Device User Register"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            updatepushToken();
                          }, child: Text("update Push Token"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            passLocation();
                          }, child: Text("Update Location"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(

                            onPressed: () {
                              newNotification();
                            }, child: Text("Add New Notification"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            readnotification();
                          }, child: Text("Read Notification By Id"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            unreadNotification();
                          }, child: Text("UnRead Notification BY Id"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            setState(() async {
                              nList = await _refluttersdkPlugin
                                  .getNotification();
                            });
                          }, child: Text("Get Notifications"),),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            readnotificationCount();
                          }, child: const Text("Read Notification Count"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            setState(() async {
                              var un_rCount = await _refluttersdkPlugin
                                  .getUnReadNotificationCount();
                              print("unReadNotificationCount:: $un_rCount");
                            });
                          }, child: const Text("Un_Read_Notification_Count"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            deleteNotificationByCampaignid();
                            setState(() {
                              controller1.clear();
                            });
                          }, child: Text("Delete Notification By CampaignId"),),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            formdataCapture();
                          }, child: Text("form Data Capture"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            ontrackEvent();
                          }, child: Text("OnTrackEvent"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            onTrackEventwithData();
                          }, child: const Text("OnTrackEventwithData"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            appconversionTracking();
                          }, child: Text("app Conversion Tracking"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            getdeepLinkData();
                          }, child: Text("Get deepLinkData"),),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            _refluttersdkPlugin.screentracking("Screen1");
                          },
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),), child: Text("Screen-1"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            _refluttersdkPlugin.screentracking("Screen-1");
                          },style:
                          ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(40),), child: Text("Screen-2"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            _refluttersdkPlugin.screentracking("Screen3");
                          }, child: Text("Screen-3"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            _refluttersdkPlugin.qrlink(
                                "http://myolaapp.page.link/start");
                          }, child: Text("QR-Link"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            _refluttersdkPlugin.notificationCTAClicked(
                                "c_id12", "a_id34");
                          }, child: Text("NotificationCTAClicked"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            _refluttersdkPlugin.getCampaiginData();
                          }, child: Text("GetCampaignData"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            _refluttersdkPlugin.deepLinkData();
                          }, child: Text("GetDeepLinkData"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                             subscribeForNotification();
                          }, child: Text("Subscribe Notification"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                           unSubscribeFromNotification();
                          }, child: Text("UnSubscribe Notification"),),
                        ),
                      ],
                    ),
                  )
              )
          )
      )
    );
  }
}
