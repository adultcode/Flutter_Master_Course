package com.example.untitled

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.telephony.SmsMessage
import android.widget.Toast
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.MethodChannel

class SmsReceiver : BroadcastReceiver() {

    val channel_name = "com.platform"

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onReceive(context: Context?, intent: Intent) {

        if(intent.action == "android.provider.Telephony.SMS_RECEIVED"){

            var channel = MethodChannel(MainActivity.flutterEngineInstance?.dartExecutor!!.binaryMessenger,
            channel_name)

            var bundle = intent.extras
            var pdus = bundle?.get("pdus") as Array<*>
            for(pdu in pdus){

                val message = SmsMessage.createFromPdu(pdu as ByteArray)
                val messagebody = message.displayMessageBody

                Toast.makeText(context,messagebody,Toast.LENGTH_SHORT).show()


                /// send data to flutter

                channel.invokeMethod("GetSMS",messagebody,object :MethodChannel.Result{
                    override fun success(result: Any?) {
                        print("--- Data sent to Flutter")
                    }

                    override fun error(
                        errorCode: String,
                        errorMessage: String?,
                        errorDetails: Any?
                    ) {
                        print("--- Error: Data sent ")
                    }

                    override fun notImplemented() {
                        TODO("Not yet implemented")
                    }


                })


            }

        }

    }


}