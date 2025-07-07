import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String? location;
  final int? temperature;

  const WeatherEntity({
    this.location,
    this.temperature,
  });

  @override
  List<Object?> get props => [location, temperature];
}
