import 'dart:async';

import 'package:flutter/material.dart';
import 'app.dart';
import 'service_locator.dart' as di;

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    di.init();
    runApp(
      const App(),
    );
  }, (error, stack) {
    debugPrint('error: $error - stack: $stack');
  });
}
