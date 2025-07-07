import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ImageEntity> images;
  final List<WeatherEntity> weathers;

  const HomeLoaded({
    required this.images,
    required this.weathers,
  });

  @override
  List<Object?> get props => [images, weathers];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object?> get props => [message];
}
