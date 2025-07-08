package com.example.flutter_image_weather_demo

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Environment
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
                    val imageUrl = call.argument<String>("imageUrl")
                    val outputPath = call.argument<String>("outputPath")
                    if (imageUrl != null && outputPath != null) {
                        downloadAndResizeImage(imageUrl, outputPath, result)
                    } else {
                        result.error("INVALID_ARGS", "Missing arguments", null)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun downloadAndResizeImage(
        imageUrl: String,
        outputPath: String,
        result: MethodChannel.Result
    ) {
        val scope = CoroutineScope(Dispatchers.Main + SupervisorJob())

        scope.launch {
            try {
                // Run image processing on IO dispatcher (background thread)
                val filePath = withContext(Dispatchers.IO) {
                    val url = URL(imageUrl)
                    val connection = url.openConnection()
                    connection.connect()
                    val inputStream = connection.getInputStream()
                    val bitmap = BitmapFactory.decodeStream(inputStream)
                    inputStream.close()

                    if (bitmap == null) {
                        throw Exception("Failed to decode image")
                    }

                    val resizedBitmap = Bitmap.createScaledBitmap(
                        bitmap,
                        bitmap.width / 2,
                        bitmap.height / 2,
                        true
                    )

                    val downloadsDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
                    val fileName = outputPath.substringAfterLast("/")
                    val file = File(downloadsDir, fileName)
                    FileOutputStream(file).use { outputStream ->
                        resizedBitmap.compress(Bitmap.CompressFormat.JPEG, 80, outputStream)
                    }

                    bitmap.recycle()
                    resizedBitmap.recycle()

                    file.absolutePath
                }

                result.success(filePath)
            } catch (e: Exception) {
                result.error("PROCESSING_ERROR", e.message, null)
            } finally {
                // Cancel scope to clean up
                scope.cancel()
            }
        }
    }
}
