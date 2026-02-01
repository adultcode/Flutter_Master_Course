package com.example.untitled

import android.content.Intent
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {


    val channel_name = "com.platform"


    companion object{
        var flutterEngineInstance:FlutterEngine?=null
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngineInstance = flutterEngine

        var channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger,channel_name)

        channel.setMethodCallHandler { call, result ->

                if(call.method=="toast"){

                    var arg = call.argument<String>("name")
                    Toast.makeText(this,"Yohouou $arg",Toast.LENGTH_SHORT).show()
                }

        }
    }
}
