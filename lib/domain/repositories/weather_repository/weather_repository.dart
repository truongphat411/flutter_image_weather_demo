import '../../entities/entities.dart';

abstract class WeatherRepository {
  Future<List<WeatherEntity>> fetchWeather();
}
