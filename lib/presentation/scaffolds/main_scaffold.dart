import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Access the global theme if needed:
    final theme = Theme.of(context);

    return Scaffold(
      // For example, you could use theme.scaffoldBackgroundColor if defined in your theme.
      backgroundColor: theme.scaffoldBackgroundColor,
      body: child,
    );
  }
}
