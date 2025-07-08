import 'package:flutter/services.dart';
import 'image_download_interface.dart';

class MethodChannelImageDownload extends ImageDownloadInterface {
  static const _channel = MethodChannel('image_download');

  @override
  Future<String> downloadAndResizeImage({
    required String imageUrl,
    required String outputPath,
  }) async {
    final path = await _channel.invokeMethod<String>(
      'downloadAndResizeImage',
      {
        'imageUrl': imageUrl,
        'outputPath': outputPath,
      },
    );
    return path ?? '';
  }
}
