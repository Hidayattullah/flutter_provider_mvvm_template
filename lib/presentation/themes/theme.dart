/// Material UI theme modification and extensions
library;

import 'layouts.dart';
import 'assets/text/app_fonts_links.dart';

final baseDialogTheme = ThemeData().dialogTheme;

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
  fontFamily: AppFontsLinks.dinPro,
  /* Overwrite existing theme data
  dialogTheme: baseDialogTheme.copyWith(
    insetPadding: const EdgeInsets.all(50),
  ),
   */
  /* Add new theme data*/
  extensions: [],
);

/// Syntax sugar
extension XExtension on ThemeData {}
