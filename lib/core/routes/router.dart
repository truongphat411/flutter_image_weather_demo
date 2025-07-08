import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_weather_demo/presentation/home/home_screen.dart';
import 'package:flutter_image_weather_demo/presentation/image_viewer/image_viewer_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home/bloc/home_bloc.dart';
import '../../presentation/home/bloc/home_event.dart';
import '../../presentation/image_viewer/bloc/image_viewer_bloc.dart';
import '../../service_locator.dart';
import 'route_path.dart';

final router = GoRouter(
  initialLocation: RouterPath.home,
  routes: [
    GoRoute(
      path: RouterPath.home,
      builder: (context, state) {
        return BlocProvider(
          create: (_) => getIt<HomeBloc>()..add(FetchHomeDataEvent()),
          child: const HomeScreen(),
        );
      },
      routes: [
        GoRoute(
          path: RouterPath.imageViewer,
          builder: (context, state) {
            final imageUrl = state.uri.queryParameters['imageUrl'] ?? '';
            return BlocProvider(
              create: (_) => getIt<ImageViewerBloc>(),
              child: ImageViewerScreen(
                imageUrl: imageUrl,
              ),
            );
          },
        ),
      ],
    ),
  ],
);
