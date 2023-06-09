package com.resul.refluttersdk

import android.app.Activity
import android.app.Application
import android.content.Context
import android.os.Bundle
import android.text.TextUtils
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



/** RefluttersdkPlugin */
class RefluttersdkPlugin : FlutterPlugin, MethodCallHandler, Application(){

    lateinit var app:Application
    private lateinit var channel: MethodChannel

    private var oldCalendar = Calendar.getInstance()
    private var sCalendar = Calendar.getInstance()

    var deepData: String? = null
    var OldScreenName: String? = null
    var newScreenName: String? = null
    var context: Context? = null
    var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context=flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "refluttersdk")
        channel.setMethodCallHandler(this)

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {

        when (call.method) {

            "sdkRegisteration" -> {
                val userDataJObj = JSONObject(call.arguments as Map<String, String>)
                val mRegisterUser = MRegisterUser()
                mRegisterUser.userUniqueId = userDataJObj.optString("userUniqueId")
                mRegisterUser.name = userDataJObj.optString("name")
                mRegisterUser.age = userDataJObj.optString("age")
                mRegisterUser.email = userDataJObj.optString("email")
                mRegisterUser.phone = userDataJObj.optString("phone")
                mRegisterUser.gender = userDataJObj.optString("gender")
                mRegisterUser.deviceToken = userDataJObj.optString("deviceToken")
                mRegisterUser.profileUrl = userDataJObj.optString("profileUrl")
                mRegisterUser.dob = userDataJObj.optString("dob")
                mRegisterUser.education = userDataJObj.optString("education")
                mRegisterUser.isEmployed = userDataJObj.optBoolean("employed")
                mRegisterUser.isMarried = userDataJObj.optBoolean("married")
                mRegisterUser.adId = userDataJObj.optString("adId")

                ReAndroidSDK.getInstance(context).onDeviceUserRegister(mRegisterUser)
            }
            "addNotification" -> {
                ReAndroidSDK.getInstance(context).addNewNotification(call.argument("notificationTitle"),call.argument("notificationBody"),"","")
            }
            "updatePushToken" -> {
                ReAndroidSDK.getInstance(context).updatePushToken(call.arguments())
            }
            "formDataCapture" -> {
                val formData = JSONObject(call.arguments as Map<String, Any>)
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

                if(context ==null) {
                    activity = Activity();
                    this.context = activity;
                }
                val screenName: String? = call.arguments()
                  if(context==null){
                  }
                if (screenName != null) {
                    if (sCalendar == null) sCalendar = Calendar.getInstance()
                    oldCalendar = sCalendar
                    sCalendar = Calendar.getInstance()
                    if (OldScreenName != null) {
                        AppConstants.CURRENT_FRAGMENT_NAME = OldScreenName;
                        AppLifecyclePresenter.getInstance()
                            .onSessionStop(
                                this.context,
                                oldCalendar,
                                sCalendar,
                                OldScreenName,
                                "",
                                ""
                            )
                        AppLifecyclePresenter.getInstance()
                            .onSessionStartFragmentForFlutter(this.context, OldScreenName, null)
                    }
                    if (newScreenName == null) newScreenName = screenName
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

                var type: String = call.arguments as String
                   if (type == "URL") {
                    ReAndroidSDK.getInstance(context).getCampaignData(object : IDeepLinkInterface {
                        override fun onInstallDataReceived(data: String) {
                            try {
                                channel.invokeMethod("onInstallDataReceived", data)

                            } catch (e: Exception) {
                                e.printStackTrace()
                            }
                        }
                        override fun onDeepLinkData(data: String) {
                            try {
                                channel.invokeMethod("onDeepLinkData", data)
                            } catch (e: Exception){
                                e.printStackTrace()
                            }
                        }
                    })
                } else if(type == "Activity") {

                        deepData = ReAndroidSDK.getInstance(context).deepLinkData
                       if (deepData != null && !TextUtils.isEmpty(deepData)) {

                            channel.invokeMethod("onDeepLinkData", deepData)

                        }

                    }

            }
            else -> {
                result.notImplemented()
            }

        }
    }

    private fun getIntent(map: Bundle): JSONObject {
        var jsonObject = JSONObject()
        try {
            val parameters: Array<Any> = map.keySet().toTypedArray()
            jsonObject = JSONObject()
            for (o in parameters) {
                val key = "" + o
                val value = "" + map[key]
                jsonObject.put(key, value)
            }
            return jsonObject
        } catch (e: java.lang.Exception) {
            ExceptionTracker.track(e)
        }
        return jsonObject
    }

    fun initReSdk(flutterContext: Context) {
        context = flutterContext
        ReAndroidSDK.getInstance(flutterContext)
        app = flutterContext as Application
      }

    fun onReceivedCampaign(remoteMessage: RemoteMessage, flutterContext: Context):Boolean{
        return ReAndroidSDK.getInstance(flutterContext).onReceivedCampaign(remoteMessage.data)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


    }


