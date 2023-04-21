package com.resul.refluttersdk

import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.google.firebase.messaging.RemoteMessage
import com.google.gson.Gson
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.mob.resu.reandroidsdk.*
import io.mob.resu.reandroidsdk.error.ExceptionTracker
import org.json.JSONObject
import java.util.*
import kotlin.collections.HashMap


/** RefluttersdkPlugin */
class RefluttersdkPlugin : FlutterPlugin, MethodCallHandler,
    Application.ActivityLifecycleCallbacks {
    lateinit var methodChannelDeeplink: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var channel: MethodChannel

    var deepData: String? = null

    var OldScreenName: String? = null
    var newScreenName: String? = null

    private var oldCalendar = Calendar.getInstance()
    private var sCalendar = Calendar.getInstance()

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "refluttersdk")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        methodChannelDeeplink = MethodChannel(flutterPluginBinding.binaryMessenger, "SDKChannel")
        var app: Application = flutterPluginBinding.applicationContext as Application
        app.registerActivityLifecycleCallbacks(this)

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {

        when (call.method) {

            "sdkRegisteration" -> {
                val userDataJObj = JSONObject(call.arguments as Map<String, String>)
                val mRegisterUser = MRegisterUser()

                mRegisterUser.userUniqueId = userDataJObj.getString("userUniqueId")
                mRegisterUser.name = userDataJObj.getString("name")
                mRegisterUser.age = userDataJObj.getString("age")
                mRegisterUser.email = userDataJObj.getString("email")
                mRegisterUser.phone = userDataJObj.getString("phone")
                mRegisterUser.gender = userDataJObj.getString("gender")
                mRegisterUser.deviceToken = userDataJObj.getString("deviceToken")
                mRegisterUser.profileUrl = userDataJObj.getString("profileUrl")
                mRegisterUser.dob = userDataJObj.getString("dob")
                mRegisterUser.education = userDataJObj.getString("education")
                mRegisterUser.isEmployed = userDataJObj.getBoolean("employed")
                mRegisterUser.isMarried = userDataJObj.getBoolean("married")
                mRegisterUser.adId = userDataJObj.getString("storeId")

                ReAndroidSDK.getInstance(context).onDeviceUserRegister(mRegisterUser)
            }
            "updatePushToken" -> {
                ReAndroidSDK.getInstance(context).updatePushToken(call.arguments())
            }
            "formDataCapture" -> {
                val formData: JSONObject = JSONObject(call.arguments as Map<String, Any>)
                ReAndroidSDK.getInstance(context).formDataCapture(formData)
            }
            "customEvent" -> {
                ReAndroidSDK.getInstance(context).onTrackEvent(call.arguments())
            }
            "customEventWithData" -> {
                val eventDataMap = call.arguments as Map<String,Any>
                val name = eventDataMap.get("name") as String
                val cdata = eventDataMap.get("data") as Map<String,Any>
                val jObject = JSONObject(cdata)
                ReAndroidSDK.getInstance(context)
                    .onTrackEvent(jObject, name)
            }
            "screenTracking" -> {
                val screenName: String? = call.arguments()
                if (screenName != null) {
                    if (sCalendar == null) sCalendar = Calendar.getInstance()
                    oldCalendar = sCalendar
                    sCalendar = Calendar.getInstance()
                    if (OldScreenName != null) {
                        activity = Activity()
                        AppLifecyclePresenter.getInstance()
                            .onSessionStop(
                                context,
                                oldCalendar,
                                sCalendar,
                                OldScreenName,
                                null,
                                null
                            )
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
                    ReAndroidSDK.getInstance(context).notificationByObject
                val gson = Gson()
                val nList = gson.toJson(notificationList)
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
            "appConversion" -> {
                ReAndroidSDK.getInstance(context).appConversionTracking()
            }
            "appConversionWithData" -> {
                val appConvertionDataJObj = JSONObject(call.arguments as Map<String, String>)
                ReAndroidSDK.getInstance(context).appConversionTracking(appConvertionDataJObj)
            }
            "deepLinkData" -> {
                var type: String = call.arguments as String;
                if (type == "URL") {
                    ReAndroidSDK.getInstance(context).getCampaignData(object : IDeepLinkInterface {
                        override fun onInstallDataReceived(data: String) {
                            try {
                                methodChannelDeeplink.invokeMethod("onInstallDataReceived", data)

                            } catch (e: Exception) {
                                e.printStackTrace()
                            }
                            Log.e("onInstallDataReceived", data)
                        }
                        override fun onDeepLinkData(data: String) {
                            try {
                                methodChannelDeeplink.invokeMethod("onDeepLinkData", data)
                            } catch (e: Exception) {
                                e.printStackTrace()
                            }
                            Log.e("onDeepLinkData", data)
                        }
                    })
                } else {
                    if (deepData != null) {
                        methodChannelDeeplink.invokeMethod("onDeepLinkData", deepData)
                    }
                }
            }
            else -> {
                result.notImplemented()
            }

        }
    }

    private fun getIntent(map: Bundle): JSONObject? {
        var jsonObject = JSONObject()
        try {
            val parameters: Array<Any> = map.keySet().toTypedArray()
            jsonObject = JSONObject()
            for (o in parameters) {
                val key = "" + o
                val value = "" + map[key]
                // Log.e("key", "" + o);
                // Log.e("values", "" + map.get(key));
                jsonObject.put(key, value)
            }
            return jsonObject
        } catch (e: java.lang.Exception) {
            ExceptionTracker.track(e)
        }
        return jsonObject
    }

    fun initReSdk(flutterContext: Context) {
        ReAndroidSDK.getInstance(flutterContext)
        AppConstants.LogFlag = true

    }

    fun clientMessageReceiver(remoteMessage: RemoteMessage, flutterContext: Context) {

        ReAndroidSDK.getInstance(flutterContext).onReceivedCampaign(remoteMessage.data)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
        if (activity.intent != null && activity.intent.extras != null) {
            try {
                val bundle = activity.intent.extras
                if (bundle != null) {
                    if (bundle.containsKey("customParams")) {
                        val activityName = bundle!!.getString("activityName", "")
                        val fragmentName = bundle.getString("fragmentName", "")
                        val jsonObject = JSONObject(bundle.getString("customParams", ""))
                        val data = getIntent(bundle);
                        deepData = data.toString();
                        /* if(methodChannelDeeplink!=null)
                             activityMethodChannel.invokeMethod("intentData", data.toString())*/
                    }
                }
            } catch (e: java.lang.Exception) {
            }
        }


    }

    override fun onActivityStarted(activity: Activity) {
    }

    override fun onActivityResumed(activity: Activity) {
    }

    override fun onActivityPaused(activity: Activity) {
    }

    override fun onActivityStopped(activity: Activity) {
    }

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
    }

    override fun onActivityDestroyed(activity: Activity) {
    }

}
