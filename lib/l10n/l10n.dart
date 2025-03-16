import 'dart:ui';

final Map<String, Locale> supportedLanguages = {
  'English': const Locale('en', 'US'),
  'Indonesia': const Locale('id', 'ID'),
};

Locale defaultSupportedLocale() {
  return supportedLanguages['Indonesia']!;
}

Locale supportedLocaleByLabel(String label) {
  return supportedLanguages[label] ?? defaultSupportedLocale();
}

String supportedLocaleLabelByLC(String langCode) {
  try {
    final e = supportedLanguages.entries.firstWhere(
      (e) => e.value.languageCode == langCode,
    );
    return e.key;
  } on StateError {
    return 'Indonesia';
  }
}

List<String> supportedLocalesLabels() {
  return supportedLanguages.keys.toList();
}
