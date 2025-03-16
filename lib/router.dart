import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
import 'presentation/scaffolds/main_scaffold.dart';
import 'presentation/screens/not_found.dart';

/// Routes are grouped by Scaffolds:
/// - Main: for the primary pages with top/bottom navbars
/// - Auth: for modal windows such as registration.
final GoRouter router = GoRouter(
  initialLocation: '/404', // Default landing page
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/404',
          builder: (context, state) => const NotFoundPage(),
          redirect: (context, state) async {
            return null;

            // final authCredentials = Provider.of<AuthCredentials>(context);
            // return authCredentials is AuthLoggedIn ? null : '/dashboard';
          },
        ),
      ],
    ),
  ],
);

/// A helper function to override the locale to Russian.
// ignore: non_constant_identifier_names
Widget Ls(BuildContext context, Widget child) {
  return Localizations.override(
    context: context,
    locale: const Locale('id'),
    child: child,
  );
}
