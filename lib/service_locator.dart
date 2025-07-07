import 'package:get_it/get_it.dart';

import 'data/datasources/datasources.dart';
import 'data/repositories_impl/repositories_impl.dart';
import 'domain/repositories/repositories.dart';
import 'domain/usecases/usecases.dart';
import 'presentation/home/bloc/home_bloc.dart';

final getIt = GetIt.instance;

void init() {
  /// Blocs
  getIt.registerFactory(() => HomeBloc(
        imageUseCase: getIt<ImageUseCase>(),
        weatherUseCase: getIt<WeatherUseCase>(),
      ));

  /// UseCases
  getIt.registerLazySingleton(
      () => ImageUseCase(repository: getIt<ImageRepository>()));
  getIt.registerLazySingleton(
      () => WeatherUseCase(repository: getIt<WeatherRepository>()));

  /// Repositories
  getIt.registerLazySingleton<ImageRepository>(() =>
      ImageRepositoryImpl(remoteDatasource: getIt<ImageRemoteDatasource>()));
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      remoteDatasource: getIt<WeatherRemoteDatasource>()));

  /// DataSources
  getIt.registerLazySingleton(() => ImageRemoteDatasource());
  getIt.registerLazySingleton(() => WeatherRemoteDatasource());
}
