class RouterPath {
  RouterPath._();
  static const home = '/home';
  static const imageViewer = '/image-viewer';
}

enum AppRouter {
  home,
  imageViewer,
}

extension AppRouterX on AppRouter {
  String get path {
    return switch (this) {
      AppRouter.home => RouterPath.home,
      AppRouter.imageViewer => RouterPath.imageViewer,
    };
  }
}
