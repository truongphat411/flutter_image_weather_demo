package com.example.flutter_image_weather_demo

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Environment
import androidx.lifecycle.lifecycleScope
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import java.io.File
import java.io.FileOutputStream
import java.net.URL

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "image_download")
            .setMethodCallHandler { call, result ->
                if (call.method == "downloadAndResizeImage") {
                    val url = call.argument<String>("url")
                    val fileName = call.argument<String>("fileName")

                    if (url.isNullOrEmpty() || fileName.isNullOrEmpty()) {
                        result.error("INVALID_ARGUMENTS", "Missing URL or fileName", null)
                        return@setMethodCallHandler
                    }

                    lifecycleScope.launch(Dispatchers.IO) {
                        try {
                            val savedPath = downloadAndResizeImage(url, fileName)
                            android.util.Log.d("ImageDownload", "Image saved successfully at $savedPath")
                            withContext(Dispatchers.Main) {
                                result.success(savedPath)
                            }
                        } catch (e: Exception) {
                            withContext(Dispatchers.Main) {
                                result.error("ERROR", e.message, null)
                            }
                        }
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun downloadAndResizeImage(url: String, fileName: String): String {
        val input = URL(url).openStream()
        val bitmap = BitmapFactory.decodeStream(input)
        val resized = Bitmap.createScaledBitmap(bitmap, bitmap.width / 2, bitmap.height / 2, true)

        val dir = getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS)
        val file = File(dir, fileName)

        val out = FileOutputStream(file)
        resized.compress(Bitmap.CompressFormat.JPEG, 90, out)
        out.flush()
        out.close()

        return file.absolutePath
    }
}
