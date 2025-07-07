import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String? url;

  const ImageEntity({
    this.url,
  });

  @override
  List<Object?> get props => [url];
}
