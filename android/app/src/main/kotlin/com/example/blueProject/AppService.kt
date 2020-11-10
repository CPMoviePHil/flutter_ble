package com.example.blueProject

import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import android.app.Activity as activity

class AppService: Service() {

    override fun onCreate() {
        super.onCreate()

        if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O)
        {
            //App()
            val notificationBuilder=NotificationCompat.Builder(this,"msgs")
                    .setContentText("Notificaiton from background Service - Flutter")
                    .setContentTitle("Background Service")
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .build()
            Log.v("OnService","OnService")
            //val manager=getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            //manager.notify((System.currentTimeMillis()%10000).toInt(),notificationBuilder)
            startForeground((System.currentTimeMillis()%10000).toInt(),notificationBuilder)
            Log.v("OnService","OnService")
        }
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {

        startService()
        return START_NOT_STICKY
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    fun startService()
    {
        Thread(Runnable {
            var k=0
            while(true)
            {
                //MainActivity main = new MainActivity()
                Log.v("OnCalling","" +k)
                Thread.sleep(1000)
                k++
            }
        }).start()

    }
}