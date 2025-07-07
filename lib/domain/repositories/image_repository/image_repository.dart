import '../../entities/entities.dart';

abstract class ImageRepository {
  Future<List<ImageEntity>> fetchImages();
}
