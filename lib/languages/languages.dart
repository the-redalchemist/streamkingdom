import 'package:flutter/material.dart';

abstract class Languages {

  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get popularTitle;

  String get trendingDayTitle;

  String get trendingWeekTitle;

  String get myList;

  String get darkMode;

  String get appearance;

  String get searchTitle;

  String get searchLabel;

  String get settingsTitle;

  String get info;

  String get language;

  String get languages;

  String get selectLanguages;

  String get home;

  String get order;

  String get activeList;

  String get inactiveList;

  String get emptyList;

  String get warningTitle;

  String get warringOrderText;

  String get ok;

}