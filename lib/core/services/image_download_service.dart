import 'package:flutter/services.dart';

class ImageDownloadService {
  static const MethodChannel _channel = MethodChannel('image_download');

  Future<String?> downloadAndResizeImage(String url, String fileName) async {
    final result = await _channel.invokeMethod<String>(
      'downloadAndResizeImage',
      {
        'url': url,
        'fileName': fileName,
      },
    );
    return result;
  }
}
