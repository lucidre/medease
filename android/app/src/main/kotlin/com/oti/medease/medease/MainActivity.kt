package com.oti.medease.medease

import android.app.DownloadManager
import android.content.Context
import android.net.Uri
import android.os.Environment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {

    private var methodChannel: MethodChannel? = null


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL_NAME
        )
        methodChannel?.setMethodCallHandler { methodCall, result ->
            when (methodCall.method) {
                FILE_DOWNLOAD -> {
                    val fileUrl = methodCall.argument<String>(KEY_FILE_URL)
                    val fileName = methodCall.argument<String>(KEY_FILE_NAME)
                    downloadFile(fileName, fileUrl)
                    result.success("file_downloaded")
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun downloadFile(fileName: String?, fileUrl: String?) {
        if (fileName == null || fileName.isEmpty()) {
            return
        }
        val mDownloadManager = getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager
        val request = DownloadManager.Request(Uri.parse(fileUrl))
        request.apply {
            setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED)
            setAllowedOverRoaming(false)
            setTitle(fileName)
            setDescription(null)
            setDestinationInExternalPublicDir(
                    Environment.DIRECTORY_DOWNLOADS,
                    File.separator + "medease" + File.separator + "files" + File.separator + fileName
            )
            setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI or DownloadManager.Request.NETWORK_MOBILE)
        }
        mDownloadManager.enqueue(request)
    }


    companion object {
        private const val CHANNEL_NAME = "native_communication"
        private const val FILE_DOWNLOAD = "downloadFile"
        private const val KEY_FILE_URL = "file_url"
        private const val KEY_FILE_NAME = "file_name"
    }
}
