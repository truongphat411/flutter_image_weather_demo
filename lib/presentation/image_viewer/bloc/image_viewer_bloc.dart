import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_weather_demo/core/core.dart';
import 'image_viewer_event.dart';
import 'image_viewer_state.dart';

class ImageViewerBloc extends Bloc<ImageViewerEvent, ImageViewerState> {
  ImageViewerBloc() : super(ImageViewerInitial()) {
    on<DownloadImage>((event, emit) async {
      emit(ImageViewerDownloading());
      try {
        final resizedImagePath =
            await ImageDownload.downloadAndResizeImage(event.imageUrl);
        emit(ImageViewerDownloadSuccess(resizedImagePath));
      } catch (e) {
        emit(ImageViewerDownloadError(e.toString()));
      }
    });
  }
}
