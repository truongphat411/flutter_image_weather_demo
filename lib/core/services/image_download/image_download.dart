import 'dart:io';

import 'package:flutter_image_weather_demo/core/services/image_download/image_download_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageDownload {
  static Future<String> downloadAndResizeImage(String imageUrl) async {
    if (Platform.isAndroid) {
      if (!await _requestStoragePermission()) {
        throw Exception('Storage permission denied');
      }
    }
    try {
      String filePath;
      if (Platform.isAndroid) {
        filePath = 'Downloads/${DateTime.now().millisecondsSinceEpoch}.jpg';
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final downloadsDir = Directory('${directory.path}/Downloads');
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        filePath =
            '${downloadsDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      }

      final result =
          await ImageDownloadInterface.instance.downloadAndResizeImage(
        imageUrl: imageUrl,
        outputPath: filePath,
      );

      return result;
    } catch (e) {
      throw Exception('Failed to process image: $e');
    }
  }

  static Future<bool> _requestStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    }

    if (Platform.isAndroid &&
        (await Permission.manageExternalStorage.status).isDenied) {
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      } else {
        await openAppSettings();
        return false;
      }
    }

    return false;
  }
}
