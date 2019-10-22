package org.stephen.flutter_open_app_store

import android.content.Intent
import android.net.Uri
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterOpenAppStorePlugin: MethodCallHandler {

  private val mRegistrar: Registrar

  constructor(mRegistrar: Registrar) {
    this.mRegistrar = mRegistrar
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "flutter_open_app_store")
      channel.setMethodCallHandler(FlutterOpenAppStorePlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if(call.method == "openAppStore"){
      val android_id = call.argument<String>("android_id")
      try {
        mRegistrar.activity().startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$android_id")))
      } catch (e: android.content.ActivityNotFoundException) {
        mRegistrar.activity().startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://play.google.com/store/apps/details?id=$android_id")))
      }
    } else {
      result.notImplemented()
    }
  }
}
