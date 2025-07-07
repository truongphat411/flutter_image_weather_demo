import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource remoteDatasource;

  WeatherRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<WeatherEntity>> fetchWeather() async {
    final weatherModel = await remoteDatasource.fetchWeather();
    return weatherModel;
  }
}
