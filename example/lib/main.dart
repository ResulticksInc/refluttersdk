import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:refluttersdk/refluttersdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReFlutterSDK-Example',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _refluttersdkPlugin = Refluttersdk();
  late FirebaseMessaging messaging;
  late var screenName;
  var token;

  @override
  void initState() {
    super.initState();
    _getFcmToken();
    _refluttersdkPlugin.listener((data) {
      print("Deeplink Data $data");
      Map<String, dynamic> notificationData = jsonDecode(data);
      String screenName = notificationData['customParams']['screenName'];
      print("ScreenName :: $screenName");
    });
  }

  Future<void> _getFcmToken() async {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print('Fcm Token: $value');
      token = value;
    });
  }

  passLocation() {
    double lat = 13.0827;
    double lang = 80.2707;
    _refluttersdkPlugin.locationUpdate(lat, lang);
  }

  customEvent() {
    var event = "On Track Event called!!!";
    _refluttersdkPlugin.customEvent(event);
  }

  customEventwithData() {
    var eventData = {
      "name": "payment",
      "data": {"id": "6744", "price": "477"}
    };
    _refluttersdkPlugin.customEventWithData(eventData);
  }

  deleteNotificationByCampaignid(campaignId) {
    _refluttersdkPlugin.deleteNotificationByCampaignId(campaignId);
  }

  readnotification(campaignId) {
    _refluttersdkPlugin.readNotification(campaignId);
  }

  unreadNotification(campaignId) {
    _refluttersdkPlugin.unReadNotification(campaignId);
  }

  appconversionTracking() {
    _refluttersdkPlugin.appConversion();
  }

  appconversionTrackingWithData() {
    Map appConversionData = {
      "name":"xyrr",
      "data":{
        "age":"23",
        "city":"yyy"
      }
    };
    _refluttersdkPlugin.appConversionWithData(appConversionData);
  }

  formdataCapture() {

    Map formData = {
      "Name": "vishwa",
      "EmailID": "abc@gmail.com",
      "MobileNo": 9329333,
      "Gender": "Male",
      "formid": 101, // required
      "apikey": "b78db6rb3-9462-4132-a4d3-894db10b3782",
      "City": "Chennai" // required
    };
    _refluttersdkPlugin.formDataCapture(formData);
  }

  updatepushToken(fcmToken) {
    _refluttersdkPlugin.updatePushToken(fcmToken);
  }

  sdkRegisteration() {

    Map userData = {
      "userUniqueId":"1111",
      "name": "kkkkk",
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
      "storeId":"555"
    };
    _refluttersdkPlugin.sdkRegisteration(userData);
  }

  readnotificationCount() async {
    var rnCount = await _refluttersdkPlugin.getReadNotificationCount();

    if (kDebugMode) {
      print("readNotificationCount::$rnCount");
    }
  }

  unReadnotificationCount() async {
    var unreadCount = await _refluttersdkPlugin.getUnReadNotificationCount();
    print("unReadNotificationCount::$unreadCount");
  }
  getNotificationList() async{
    var notificationList = await _refluttersdkPlugin.getNotificationList();
    print("GetNotificationList::$notificationList");
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('ReFlutter - Sdk'),
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
                              sdkRegisteration();
                            }, child: Text("On Device User Register"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              updatepushToken(token);
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
                            child: ElevatedButton(onPressed: () {
                              readnotification("w39|G|qqD|iF|DEA5Q|430404|Bulk|20230418060124");
                            }, child: Text("Read Notification By Id"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              unreadNotification("w39|G|qqD|iF|DEA5Q|430404|Bulk|20230418060124");
                            }, child: Text("UnRead Notification BY Id"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              getNotificationList();
                            }, child: Text("Get Notification List"),),
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
                              unReadnotificationCount();
                            }, child: const Text("Un_Read_Notification_Count"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              deleteNotificationByCampaignid("w39|G|qqD|iF|DEA5Q|430404|Bulk|20230418060124");
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
                              customEvent();
                            }, child: Text("customEvent"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40),);
                              customEventwithData();
                            }, child: const Text("customEventwithData"),),
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
                              ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40),);
                              appconversionTrackingWithData();
                            }, child: Text("App Conversion Tracking WithData"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40),);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // Call the system service here
                                _refluttersdkPlugin.screentracking("page1");
                              });
                              //_refluttersdkPlugin.screentracking("Page1");
                            }, child: Text("Page-1"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40),);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // Call the system service here
                                _refluttersdkPlugin.screentracking("page2");
                              });
                              //_refluttersdkPlugin.screentracking("Page2");
                            }, child: Text("Page-2"),),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(onPressed: () {
                              ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40),);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // Call the system service here
                                _refluttersdkPlugin.screentracking("page3");
                              });
                              //_refluttersdkPlugin.screentracking("Page3");
                            }, child: Text("Page-3"),),
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


