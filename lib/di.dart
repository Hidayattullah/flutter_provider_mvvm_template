import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

final log = Logger('AppDependenciesProvider');

class AppDependenciesProvider extends StatelessWidget {
  final Widget child;

  const AppDependenciesProvider(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [], child: child);
  }
}
