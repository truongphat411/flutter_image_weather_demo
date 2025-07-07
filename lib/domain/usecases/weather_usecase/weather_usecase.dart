import '../../entities/entities.dart';
import '../../../domain/repositories/repositories.dart';

class WeatherUseCase {
  final WeatherRepository repository;

  WeatherUseCase({required this.repository});

  Future<List<WeatherEntity>> fetchWeather() async {
    return await repository.fetchWeather();
  }
}
