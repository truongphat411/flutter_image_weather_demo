import 'package:flutter_image_weather_demo/core/services/image_download/image_download_interface.dart';
import 'package:path_provider/path_provider.dart';

class ImageDownload {
  static Future<String> downloadAndResizeImage(String imageUrl) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final filePath = '${directory.path}/$fileName';

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
}
