package com.resul.refluttersdk_example
import android.os.Bundle
import com.resul.refluttersdk.RefluttersdkPlugin
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        RefluttersdkPlugin().initReSdk(this)
    }




}
