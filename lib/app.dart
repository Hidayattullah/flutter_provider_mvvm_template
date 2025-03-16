import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

// Import hasil generate l10n
// ^ Pastikan path sesuai, misalnya:
//   import 'package:GB_TLV_Church/l10n.dart';
//   jika path project berbeda

// import 'app_theme.dart'; // contoh import theme
import 'router.dart'; // contoh import router

final _log = Logger("l10n");

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  // Default locale: misalnya 'en' untuk Inggris
  Locale locale = const Locale('id', 'ID');

  void setLocale(Locale newLocale) {
    _log.finest('AppState.setLocale($newLocale)');
    setState(() {
      locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    _log.finest('AppState.build(locale=$locale)');
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'GBI_LV',
      // theme: appTheme,

      // Delegates yang dibutuhkan:
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Locale saat ini (bisa diubah runtime via setLocale)
      locale: locale,

      // Router config
      routerConfig: router,
    );
  }
}
