import 'package:flutter/material.dart';
import 'package:streamkingdom/languages/language_en.dart';
import 'package:streamkingdom/languages/language_de.dart';

import 'languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {

  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        print("en");
        return LanguageEn();
      case 'de':
        print("de");
        return LanguageDe();
      default:
        print("default");
        return LanguageDe();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}