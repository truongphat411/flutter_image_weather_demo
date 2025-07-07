import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDatasource remoteDatasource;

  ImageRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<ImageEntity>> fetchImages() async {
    final imageModels = await remoteDatasource.fetchImages();
    return imageModels;
  }
}
