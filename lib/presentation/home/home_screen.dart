import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_weather_demo/presentation/home/widgets/home_tile.dart';
import 'package:go_router/go_router.dart';
import '../../core/routes/route_path.dart';
import '../../domain/entities/entities.dart';
import '../components/common_app_bar.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  WeatherEntity _getHoChiMinhWeather(List<WeatherEntity> weathers) {
    return weathers.firstWhere(
      (e) => e.location == 'Ho Chi Minh',
      orElse: () => throw Exception('Ho Chi Minh not found'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        elevation: 0,
        title: Text(
          'Demo App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is! HomeLoaded) {
            return const SizedBox.shrink();
          }

          final images = state.images;
          final hoChiMinhWeather = _getHoChiMinhWeather(state.weathers);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${hoChiMinhWeather.location} city',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${hoChiMinhWeather.temperature}°C',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    physics: const ClampingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 18,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      return HomeTile(
                        imageUrl: image.url ?? '',
                        onTap: () {
                          context.push(
                            '${RouterPath.home}${RouterPath.imageViewer}?imageUrl=${image.url}',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
