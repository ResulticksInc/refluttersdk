package com.resul.refluttersdk

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

import io.mob.resu.reandroidsdk.*
import org.json.JSONObject
import com.google.gson.Gson
import android.util.Log
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.JsonParser


/** RefluttersdkPlugin */
class RefluttersdkPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context
    private lateinit var activity: Activity
    var OldScreenName: String? = null
    var newScreenName: String? = null
    private var oldCalendar = Calendar.getInstance()
    private var sCalendar = Calendar.getInstance()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "refluttersdk")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {

        when (call.method) {

            "sdkRegisteration" -> {
                val gson = Gson()
                var jsonString: String? = call.argument("userData")
                val jsonElement = JsonParser.parseString(jsonString)

                val jObj = jsonElement.asJsonObject
                val userUniqueId = jObj.get("userUniqueId").asString
                val name = jObj.get("name").asString
                val age = jObj.get("age").asString
                val email = jObj.get("email").asString
                val phone = jObj.get("phone").asString
                val gender = jObj.get("gender").asString
                val token = jObj.get("deviceToken").asString
                val profileUrl = jObj.get("profileUrl").asString
                val dob = jObj.get("dob").asString
                val education = jObj.get("education").asString
                val employed = jObj.get("employed").asBoolean
                val married = jObj.get("married").asBoolean
                val adId = jObj.get("storeId").asString

                val obj = MRegisterUser()
                obj.userUniqueId = userUniqueId
                obj.name = name
                obj.age = age
                obj.email = email
                obj.phone = phone
                obj.gender = gender
                obj.deviceToken = token
                obj.profileUrl = profileUrl
                obj.dob = dob
                obj.education = education
                obj.adId = adId
                if (employed != null) {
                    obj.isEmployed = employed
                }
                if (married != null) {
                    obj.isMarried = married
                }
                ReAndroidSDK.getInstance(context).onDeviceUserRegister(obj)
            }
            "updatePushToken" -> {
                var token: String? = call.argument("regToken")
                ReAndroidSDK.getInstance(context).updatePushToken(token)
            }
            "formDataCapture" -> {
                var formData: String? = call.argument("formData")
                val jobj = JSONObject(formData)
                if (formData != null) {
                    ReAndroidSDK.getInstance(context).formDataCapture(jobj)
                }
            }
            "customEvent" -> {
                var content: String? = call.argument("string")
                if (content != null) {
                    ReAndroidSDK.getInstance(context).onTrackEvent(content)
                }
            }
            "customEventWithData" -> {
                val event: String? = call.argument("event")
                val eventData: String? = call.argument("eventData")
                val jobj = eventData?.let { JSONObject(it) }
                if (eventData != null) {
                    ReAndroidSDK.getInstance(context).onTrackEvent(jobj, event)
                }
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

                val hashMap: HashMap<Int, HashMap<String, String>> = HashMap()
                for (i in notificationList.indices) {
                    val jsonObj: JSONObject = notificationList[i]
                    val keys: Iterator<String> = jsonObj.keys()
                    val jsonMap: HashMap<String, String> = HashMap()

                    while (keys.hasNext()) {
                        val key: String = keys.next()
                        val value: String = jsonObj.getString(key)
                        jsonMap.put(key, value)
                    }
                    hashMap[i] = jsonMap
                }
                print("HashMap :: $hashMap")
                result.success(nList)
            }
            "deleteNotificationByCampaignId" -> {
                var cid: String? = call.argument("cid")
                if (cid != null) {
                    ReAndroidSDK.getInstance(context).deleteNotificationByCampaignId(cid)
                }
            }
            "getReadNotificationCount" -> {
                result.success(ReAndroidSDK.getInstance(context).readNotificationCount)
            }
            "getUnReadNotificationCount" -> {
                result.success(ReAndroidSDK.getInstance(context).unReadNotificationCount)
            }
            "readNotification" -> {
                var cid: String? = call.argument("cid")
                if (cid != null) {
                    ReAndroidSDK.getInstance(context).readNotification(cid)
                }
            }
            "unReadNotification" -> {
                var cid: String? = call.argument("cid")
                if (cid != null) {
                    ReAndroidSDK.getInstance(context).unReadNotification(cid)
                }
            }
            "locationUpdate" -> {
                var lat: Double? = call.argument("lat")
                var lang: Double? = call.argument("lang")
                if (lat != null && lang != null) {
                    ReAndroidSDK.getInstance(context).onLocationUpdate(lat, lang)
                }
            }
            "addNewNotification" -> {
                var title: String? = call.argument("title")
                var body: String? = call.argument("body")
                if (title != null && body != null) {
                    ReAndroidSDK.getInstance(context).addNewNotification(title, body, "MainActivity")
                }
            }
            "appConversion" -> {
                ReAndroidSDK.getInstance(context).appConversionTracking()
            }
            "appConversionWithData" -> {
                val jsonString: String? = call.argument("appConvertionData")
                val jsonObject = JSONObject(jsonString)
                ReAndroidSDK.getInstance(context).appConversionTracking(jsonObject)
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
                val campainId: String? = call.argument("campaignId")
                val actionId: String? = call.argument("actionId")
                ReAndroidSDK.getInstance(context).notificationCTAClicked(campainId, actionId)
            }
            "getCampaignData" -> {
                print("GetCampaiganDataCalled!!!")
                ReAndroidSDK.getInstance(context).getCampaignData(object : IDeepLinkInterface {
                    override fun onInstallDataReceived(data: String) {
                        try {
                            val jsonObject = JSONObject(data)
                            print("onInstallDataReceived :: $jsonObject")
                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                        Log.e("onInstallDataReceived", data)
                    }

                    override fun onDeepLinkData(data: String) {
                        Log.e("onDeepLinkData", data)
                        try {
                            val jsonObject = JSONObject(data)
                            print("onDeepLinkData :: $jsonObject")

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

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

}
