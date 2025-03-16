import 'package:flutter/material.dart';

import 'package:logging/logging.dart';
import 'app.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'di.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  /// configure URL formats for web
  configureApp();

  /// New, GetX-free Application
  /// It is wrapped with Provided on the very top
  /// so provider become available in the any
  /// widget
  runApp(const AppDependenciesProvider(App()));
}
