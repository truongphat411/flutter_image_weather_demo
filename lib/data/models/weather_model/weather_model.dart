import '../../../domain/entities/entities.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    super.location,
    super.temperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location'] as String?,
      temperature: json['temperature'] as int?,
    );
  }
}
