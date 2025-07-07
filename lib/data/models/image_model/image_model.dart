import '../../../domain/entities/entities.dart';

class ImageModel extends ImageEntity {
  const ImageModel({
    super.url,
  });

  factory ImageModel.fromJson(dynamic json) {
    return ImageModel(url: json as String?);
  }
}
