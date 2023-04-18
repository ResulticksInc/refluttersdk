package com.resul.refluttersdk

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.Gson
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.mob.resu.reandroidsdk.*
import org.json.JSONObject
import java.util.*


/** RefluttersdkPlugin */
class RefluttersdkPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    lateinit var methodChannelforDeeplink:MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var channel: MethodChannel

    var OldScreenName: String? = null
    var newScreenName: String? = null

    private var oldCalendar = Calendar.getInstance()
    private var sCalendar = Calendar.getInstance()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "refluttersdk")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext

//         methodChannelforDeeplink = MethodChannel(flutterPluginBinding.binaryMessenger, "myChannel")

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {

        when (call.method) {

            "sdkRegisteration" -> {
                val userDataJObj = JSONObject(call.arguments as Map<String,String>)
                val mRegisterUser= MRegisterUser()

                mRegisterUser.userUniqueId  = userDataJObj.getString("userUniqueId")
                mRegisterUser.name = userDataJObj.getString("name")
                mRegisterUser.age = userDataJObj.getString("age")
                mRegisterUser.email = userDataJObj.getString("email")
                mRegisterUser.phone = userDataJObj.getString("phone")
                mRegisterUser.gender = userDataJObj.getString("gender")
                mRegisterUser.deviceToken = userDataJObj.getString("deviceToken")
                mRegisterUser.profileUrl = userDataJObj.getString("profileUrl")
                mRegisterUser.dob = userDataJObj.getString("dob")
                mRegisterUser.education = userDataJObj.getString("education")
                mRegisterUser.isEmployed  = userDataJObj.getBoolean("employed")
                mRegisterUser.isMarried = userDataJObj.getBoolean("married")
                mRegisterUser.adId= userDataJObj.getString("storeId")

                ReAndroidSDK.getInstance(context).onDeviceUserRegister(mRegisterUser)
            }
            "updatePushToken" -> {
                ReAndroidSDK.getInstance(context).updatePushToken(call.arguments())
            }
            "formDataCapture" -> {
                val formData:JSONObject = JSONObject(call.arguments as Map<String, Any>)
                    ReAndroidSDK.getInstance(context).formDataCapture(formData)
            }
            "customEvent" -> {
                    ReAndroidSDK.getInstance(context).onTrackEvent(call.arguments())
            }
            "customEventWithData" -> {
                val eventDataMap = call.argument<Map<String, Any>>("eventData")
                val eventDataJson = JSONObject()
                if (eventDataMap != null) {
                    for ((key, value) in eventDataMap) {
                        eventDataJson.put(key, value)
                    }
                }
                ReAndroidSDK.getInstance(context).onTrackEvent(eventDataJson, call.argument("event"))
            }
            "screenTracking" -> {
                val screenName: String? = call.argument("screenname")
                if (screenName != null) {
                    if (sCalendar == null) sCalendar = Calendar.getInstance()
                    oldCalendar = sCalendar
                    sCalendar = Calendar.getInstance()
                    if (OldScreenName != null) {
                        activity = Activity()
                        // context=mycontext
                        AppLifecyclePresenter.getInstance()
                            .onSessionStop(context, oldCalendar, sCalendar, OldScreenName, null, null)
                        AppLifecyclePresenter.getInstance()
                            .onSessionStartFragment(activity, OldScreenName, null)
                    }
                    if (newScreenName == null) newScreenName = screenName
                    // screenTracking(screenName)
                }
                OldScreenName = newScreenName
                newScreenName = screenName
            }
            "getNotificationList" -> {
                var notificationList: ArrayList<JSONObject> =
                    ReAndroidSDK.getInstance(context).notificationByObject;
                val gson = Gson()
                val nList = gson.toJson(notificationList)
                print("HashMap :: $nList")
                result.success(nList)
            }
            "deleteNotificationByCampaignId" -> {
                    ReAndroidSDK.getInstance(context).deleteNotificationByCampaignId(call.arguments())
            }
            "getReadNotificationCount" -> {
                result.success(ReAndroidSDK.getInstance(context).readNotificationCount)
            }
            "getUnReadNotificationCount" -> {
                result.success(ReAndroidSDK.getInstance(context).unReadNotificationCount)
            }
            "readNotification" -> {

                    ReAndroidSDK.getInstance(context).readNotification(call.arguments())
            }
            "unReadNotification" -> {

                    ReAndroidSDK.getInstance(context).unReadNotification(call.arguments())

            }
            "locationUpdate" -> {
                var lat: Double? = call.argument("lat")
                var lang: Double? = call.argument("lang")
                if (lat != null && lang != null) {
                    ReAndroidSDK.getInstance(context).onLocationUpdate(lat, lang)
                }
            }
            "addNewNotification" -> {
                    ReAndroidSDK.getInstance(context).addNewNotification(call.argument("title"),call.argument("body") , "MainActivity")
            }
            "appConversion" -> {
                ReAndroidSDK.getInstance(context).appConversionTracking()
            }
            "appConversionWithData" -> {
                val appConvertionDataJObj = JSONObject(call.arguments as Map<String,String>)
                ReAndroidSDK.getInstance(context).appConversionTracking(appConvertionDataJObj)
            }
            "deepLinkData" -> {
                print("DeepLinkData!!!")
                var deepLinkData = ReAndroidSDK.getInstance(context).deepLinkData
                print("DeepLinkData :: $deepLinkData")
            }
            "qrlink" -> {
                class MyIGetQR : IGetQRLinkDetail {
                    override fun onSmartLinkDetails(p0: String?) {
                    }

                    override fun onError(p0: String?) {
                    }
                }

                val myLink: String? = call.argument("myLink")
                ReAndroidSDK.getInstance(context).handleQrLink(myLink, MyIGetQR())
            }
            "notificationCTAClicked" -> {

                ReAndroidSDK.getInstance(context).notificationCTAClicked(call.argument("campaignId"),call.argument("actionId"))
            }
            "getCampaignData" -> {

                ReAndroidSDK.getInstance(context).getCampaignData(object : IDeepLinkInterface {
                    override fun onInstallDataReceived(data: String) {
                        try {
                            val jsonObject = JSONObject(data)
                      //handle here
                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                        Log.e("onInstallDataReceived", data)
                    }

                    override fun onDeepLinkData(data: String) {
                        Log.e("onDeepLinkData", data)
                        try {
                            val jsonObject = JSONObject(data)
                          //handle here

                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                    }
                })
            }
            else -> {
                result.notImplemented()
            }

        }

    }

    fun initReSdk(flutterContext: Context) {
        ReAndroidSDK.getInstance(flutterContext)
        AppConstants.LogFlag = true
        io.flutter.Log.d("initsdk", "SDK initialized1")
    }

    fun clientMessageReceiver(remoteMessage: RemoteMessage, flutterContext: Context) {
        io.flutter.Log.d("msgTrace", "From native code!!!!")
        ReAndroidSDK.getInstance(flutterContext).onReceivedCampaign(remoteMessage.data)
    }
//
//    private fun callFlutterMethod(receivedData: String) {
//
//        methodChannelforDeeplink.invokeMethod("myMethod", receivedData)
//    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

}
