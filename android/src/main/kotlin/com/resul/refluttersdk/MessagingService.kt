package com.resul.refluttersdk_example

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build

import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.resul.refluttersdk.RefluttersdkPlugin
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import io.flutter.Log
import android.os.Bundle

class MessagingService : FirebaseMessagingService(){
    lateinit var token:String
    val bundle = Bundle()
    override fun onNewToken(tokken: String) {
        super.onNewToken(tokken)
        token=tokken
        Log.i("token", "Refreshed token :: $tokken")
    }
     override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        var intent: Intent = Intent("com.example.fluttersdkplugin_example/MY_EVENT");
        intent.putExtra("message",remoteMessage.notification?.title);
        sendBroadcast(intent);
        Log.d("msgTrace", "RemoteMessage!!!!")
        RefluttersdkPlugin().clientMessageReceiver(remoteMessage,this)
     }

}





