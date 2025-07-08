abstract class ImageViewerState {}

class ImageViewerInitial extends ImageViewerState {}

class ImageViewerDownloading extends ImageViewerState {}

class ImageViewerDownloadSuccess extends ImageViewerState {
  final String filePath;

  ImageViewerDownloadSuccess(this.filePath);
}

class ImageViewerDownloadError extends ImageViewerState {
  final String message;

  ImageViewerDownloadError(this.message);
}
