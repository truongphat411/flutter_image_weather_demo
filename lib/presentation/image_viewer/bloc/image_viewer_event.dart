abstract class ImageViewerEvent {}

class DownloadImage extends ImageViewerEvent {
  final String imageUrl;

  DownloadImage(this.imageUrl);
}
