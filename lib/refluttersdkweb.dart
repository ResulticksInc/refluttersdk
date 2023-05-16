import 'package:flutter/foundation.dart';
import 'remobile.dart'
    if (dart.library.js) 'rewebsdk.dart';


class ReFlutterWebSDK {
 
  static void initWebSDK(String fcmPath) {
    if(kIsWeb){
        ReFlutterWeb.initWebSDK(fcmPath);
    }
  }
  static void userRegister(Map data) {
     if(kIsWeb){
        ReFlutterWeb.userRegister(data);
    }
  }
  static void updatePushToken(String s){
     if(kIsWeb){
        ReFlutterWeb.updatePushToken(s);
    }
  }
  static void customEventWithData(Map event){
    if(kIsWeb){
        ReFlutterWeb.customEventWithData(event);
    }
  }
  static void customEvent(String event){
    if(kIsWeb){
        ReFlutterWeb.customEvent(event);
    }
  }
  static void userLocation(double lat,double lang){
    if(kIsWeb){
        ReFlutterWeb.userLocation(lat,lang);
    }
  }
  static void webConversationTracking(){
     if(kIsWeb){
        ReFlutterWeb.webConversationTracking();
    }
  }
  
}
