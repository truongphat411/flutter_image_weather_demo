import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_weather_demo/presentation/components/common_app_bar.dart';
import '../../core/services/image_download_service.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  Future<void> _downloadImage(BuildContext context) async {
    try {
      String fileName = Uri.parse(imageUrl).pathSegments.last.split('?').first;
      if (fileName.isEmpty || !fileName.contains('.')) {
        fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      }

      await ImageDownloadService().downloadAndResizeImage(
        imageUrl,
        fileName,
      );
    } catch (e) {
      log('Error downloading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      appBar: CommonAppBar(
        backgroundColor: const Color(0xFF333333),
        isIconBack: false,
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/ic_download.png',
              color: Colors.white,
              height: 30,
            ),
            onPressed: () => _downloadImage(context),
          ),
          IconButton(
            icon: Image.asset(
              'assets/ic_close.png',
              color: Colors.white,
              height: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100),
          ),
        ),
      ),
    );
  }
}
