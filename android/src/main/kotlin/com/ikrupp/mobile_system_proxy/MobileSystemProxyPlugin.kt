package com.ikrupp.mobile_system_proxy

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** MobileSystemProxyPlugin */
public class MobileSystemProxyPlugin : FlutterPlugin, MethodCallHandler {
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "mobile_system_proxy")
        channel.setMethodCallHandler(MobileSystemProxyPlugin());
    }


    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "mobile_system_proxy")
            channel.setMethodCallHandler(MobileSystemProxyPlugin())
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getProxy") {
            result.success(getSystemProxy()?.encode())
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }
}

private fun getSystemProxy(): Proxy? {
    try {
        val proxyAddress: String? = System.getProperty("http.proxyHost") ?: return null
        val proxyPort = Integer.parseInt(System.getProperty("http.proxyPort") ?: "-1")
        return Proxy(host = proxyAddress, port = proxyPort)
    } catch (exc: Exception) {
        return null
    }
}

class Proxy(private val host: String?, private val port: Int?) {
    fun encode(): List<Any?> {
        return arrayListOf(host, port)
    }
}
