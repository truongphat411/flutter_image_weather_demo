import 'image_download_method_channel.dart';

abstract class ImageDownloadInterface {
  ImageDownloadInterface() : super();

  static final ImageDownloadInterface _instance = MethodChannelImageDownload();

  static ImageDownloadInterface get instance => _instance;

  Future<String> downloadAndResizeImage({
    required String imageUrl,
    required String outputPath,
  }) async {
    throw UnimplementedError(
      'downloadAndResizeImage() has not been implemented.',
    );
  }
}
