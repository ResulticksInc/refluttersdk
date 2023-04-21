package com.resul.visionbank

import android.app.Application
import com.resul.refluttersdk.RefluttersdkPlugin

class VisionBankApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        RefluttersdkPlugin().initReSdk(this)
    }
}