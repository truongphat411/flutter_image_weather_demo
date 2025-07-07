import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImageUseCase imageUseCase;
  final WeatherUseCase weatherUseCase;

  HomeBloc({
    required this.imageUseCase,
    required this.weatherUseCase,
  }) : super(HomeInitial()) {
    on<FetchHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final results = await Future.wait([
          imageUseCase.fetchImages(),
          weatherUseCase.fetchWeather(),
        ]);
        final images = results[0] as List<ImageEntity>;
        final weathers = results[1] as List<WeatherEntity>;
        emit(HomeLoaded(
          images: images,
          weathers: weathers,
        ));
      } catch (e) {
        emit(HomeError(message: e.toString()));
      }
    });
  }
}
