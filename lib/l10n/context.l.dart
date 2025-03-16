import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logging/logging.dart';

import '../app.dart';
import 'l10n.dart';

final _log = Logger("l10n");

extension LocalizationExtension on BuildContext {
  AppLocalizations get l => AppLocalizations.of(this)!;
  void selectLocaleByLabel(String lang) {
    final locale = supportedLocaleByLabel(lang);
    final state = findAncestorStateOfType<AppState>();
    _log.finest('selectLocaleByLabel($lang) -> $locale');
    state?.setLocale(locale);
  }

  String selectedLocaleLabel() {
    final state = findAncestorStateOfType<AppState>();
    final label = supportedLocaleLabelByLC(state?.locale.languageCode ?? 'en');
    _log.finest('selectedLocaleLabel ${state?.locale.languageCode}/$label');
    return label;
  }
}
