import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_weather_demo/presentation/components/common_app_bar.dart';
import 'package:flutter_image_weather_demo/presentation/image_viewer/bloc/image_viewer_bloc.dart';

import '../../core/core.dart';
import 'bloc/image_viewer_event.dart';
import 'bloc/image_viewer_state.dart';

class ImageViewerScreen extends StatelessWidget {
  const ImageViewerScreen({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333333),
      appBar: CommonAppBar(
        backgroundColor: const Color(0xFF333333),
        isIconBack: false,
        actions: [
          BlocBuilder<ImageViewerBloc, ImageViewerState>(
            buildWhen: (p, c) => p.runtimeType != c.runtimeType,
            builder: (context, state) {
              return IconButton(
                icon: Image.asset(
                  'assets/ic_download.png',
                  color: Colors.white,
                  height: 30,
                ),
                onPressed: state is ImageViewerDownloading
                    ? null
                    : () => context
                        .read<ImageViewerBloc>()
                        .add(DownloadImage(imageUrl)),
              );
            },
          ),
          IconButton(
            icon: Image.asset(
              'assets/ic_close.png',
              color: Colors.white,
              height: 30,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 100),
          ),
        ),
      ),
    );
  }
}
