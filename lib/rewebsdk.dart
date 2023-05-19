import 'dart:html' as html;
import 'refluttersdkweb.dart';
import 'dart:js' as js;

class ReFlutterWeb {
   static final  sdk = js.context['ReWebSDK'];
   static final obj = js.JsObject(js.context['Object']);
  static void initWebSDK(String fcmPath) {
    html.Element? head = html.document.querySelector('head');
    html.ScriptElement script = html.ScriptElement();
    script.defer = true;
    script.src = "https://sdk.rsut.io/handlers/5f7a2e8e1bdb47399d28278a2759394c.sdk";
    script.setAttribute('fcm_service_path', fcmPath.toString());
    head?.append(script);
    setupCustomEventListener(fcmPath);
  }

   static void setupCustomEventListener(fcmPath) {
     html.window.addEventListener("sdk_ready", (event) => {
       sdk.callMethod('serviceWorkerFilePath',[fcmPath] )
     });
   }

   static void userRegister(Map userData) {
      obj['userUniqueId'] = userData['userUniqueId'].toString();
     if (userData['email'] != null ) {
       obj['email'] = userData['email'].toString();
     }
     if (userData['phone'] != null) {
       obj['phone'] = userData['phone'].toString();
     }
     if (userData['name'] != null) {
       obj['name'] = userData['name'].toString();
     }
     if (userData['profileUrl'] != null) {
       obj['profileUrl'] = userData['profileUrl'].toString();
     }
     if (userData['age'] != null) {
       obj['age'] = userData['age'].toString();
     }
     if (userData['dateOfBirth'] != null) {
       obj['dateOfBirth'] = userData['dateOfBirth'].toString();
     }
     if (userData['gender'] != null) {
       obj['gender'] = userData['gender'].toString();
     }
     sdk.callMethod('userRegister', [obj]);
  }
  static void updatePushToken(String s){

  }
  static void customEventWithData(Map event){
     for (var entry in event.entries) {
        print('${entry.key}: ${entry.value}');
        obj[entry.key] = entry.value.toString();
      }
    sdk.callMethod('customEvent', [obj]);
  }
  static void customEvent(String event){
     obj['eventName'] = event;
    sdk.callMethod('customEvent', [obj]);
  }    
  static void userLocation(double lat,double lang){
    obj['latitude'] = lat;
    obj['longitude'] = lang;
    sdk.callMethod('userLocation', [obj]);
  }
  static void webConversationTracking(){
      sdk.callMethod('conversionTracking');
  }
   static void userLogout(){
     sdk.callMethod('userLogout');
   }


}