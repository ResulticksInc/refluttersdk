import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:refluttersdk/refluttersdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni_links/uni_links.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _initialURILinkHandled = false;
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;
  StreamSubscription? _streamSubscription;
  
  String _platformVersion = 'Unknown';
  final _refluttersdkPlugin = Refluttersdk();
      String token = "dEHA8nVPTq6wHFINot8wu-:APA91bHGLIoi2wp2tPmzMuVSqFtC3_KnB4lyXnzGhezi9MMwTiFzxrr1flBo_ltcgh0nI22QuXdStKk7W7mxA9MftHU15NmZKpcvRrcTXEUYAI1dkIpkqwzYpUl3jFKz8Bm9JDK-uf9m";
  int notificationCount = 0,
      _counter = 0;
  late String cid;
  late String nList;
  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
   /// _initURIHandler();
   // _incomingLinkHandler();
    //initiateMethodChannel();
    getdeepLinkData();
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

  customEvent() {
    var content = "On Track Event called!!!";
    _refluttersdkPlugin.customEvent(content);
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
    _refluttersdkPlugin.appConversion();
  }
  appconversionTrackingWithData() {
    Map appConvertionData={
      "name":"xyrr",
      "age":"23",
      "city":"dhajf"};
    _refluttersdkPlugin.appConversionWithData(appConvertionData);
  }

  formdataCapture() {
    Map formData = {
      "Name": "vishwa",
      "EmailID": "abc@gmail.com",
      "MobileNo": 9329333,
      "Gender": "Male",
      "formid": 101, // required
      "apikey": "api_key_b78db6rb3-9462-4132-a4d3-894db10b3782",
      "City": "Chennai" // required
    };
    _refluttersdkPlugin.formDataCapture(formData);
  }

  customEventwithData() {
    var eventData = {
      "name": "payment",
      "data": {"id": "6744", "price": "477"}
    };
    _refluttersdkPlugin.customEventWithData(eventData);
  }

  updatepushToken() {
    _refluttersdkPlugin.updatePushToken(token);
  }
  ondeviceRegister() {

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
 

  getdeepLinkData() {
    _refluttersdkPlugin.deepLinkData((String data)=> {
      //showAlert(bcontext,data)
       print('onInstallDataReceived :: $data')
    });
  }

// receiveDeeplink(String data){
//     print("Deeplink Received :: $data");
// }
//   getdeepLinkData() {
//     _refluttersdkPlugin.deepLinkData(receiveDeeplink);
//   }


  void showAlert(BuildContext context,String type) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: Text('Notification firebase'),
            content: Text( "Message state:${type} "),
          );
        });
  }



  readnotificationCount() async {
    var rnCount = await _refluttersdkPlugin.getReadNotificationCount()!;
    setState(() {
      notificationCount = rnCount!;
    });
    if (kDebugMode) {
      print("readNotificationCount::$rnCount");
    }
  }

  unReadnotificationCount() async {
    var unreadCount = await _refluttersdkPlugin.getUnReadNotificationCount()!;
    print("unReadNotificationCount::$unreadCount");
  }
  getNotificationList() async{
    var notificationList = await _refluttersdkPlugin.getNotificationList();
    print("GetNotificationList::$notificationList");
  }


subscribeForNotification() async {
 await FirebaseMessaging.instance.subscribeToTopic("resul");
}
unSubscribeFromNotification() {
  FirebaseMessaging.instance.unsubscribeFromTopic("resul");
}

  void onInastallDataReceived(String message) {
    print('onInstallDataReceived :: $message');
  }
  void onDeepLinkData(String message) {
    print('onDeepLinkData :: $message');
  }


   var bcontext ;
// Platform messages are asynchronous, so we initialize in an async method.
  @override
  Widget build(BuildContext context) {
    bcontext =context;
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
                            customEvent();
                          }, child: Text("customEvent"),),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(onPressed: () {
                            style:
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
                            style:
                            ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),);
                            appconversionTrackingWithData();
                          }, child: Text("AppConvertionTrackingWithData"),),
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
                            // _refluttersdkPlugin.deepLinkData();
                            getdeepLinkData();
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
