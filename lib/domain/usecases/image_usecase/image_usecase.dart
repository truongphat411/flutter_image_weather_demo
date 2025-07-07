import '../../../domain/repositories/repositories.dart';
import '../../entities/entities.dart';

class ImageUseCase {
  final ImageRepository repository;

  ImageUseCase({required this.repository});

  Future<List<ImageEntity>> fetchImages() async {
    return await repository.fetchImages();
  }
}
