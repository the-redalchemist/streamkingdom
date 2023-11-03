// this enum will help with the Theme type
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/SharedPrefsService.dart';

enum ThemeType { light, dark }

//provider
class ThemeProvider extends ChangeNotifier {
// new line
  SavePreference pre = SavePreference();
  ThemeData currentTheme = darkTheme;
  ThemeType themeType = ThemeType.dark;

// new
  ThemeProvider() {
    setInitialTheme();
  }

// new method
  setInitialTheme() {
    ThemeData theme = ThemeData.dark();
    pre.getTheme().then((value) {
      theme = (value) ? darkTheme : lightTheme;
      currentTheme = theme;
      themeType = (theme == lightTheme) ? ThemeType.light : ThemeType.dark;
      notifyListeners();
    });
  }

  changeCurrentTheme(bool theme) {
// new line
    if (currentTheme == darkTheme) {
      themeType = ThemeType.light;
      currentTheme = lightTheme;
    } else {
      themeType = ThemeType.dark;
      currentTheme = darkTheme;
    }
    pre.setTheme(theme);
    notifyListeners();
  }

  Future<bool> getDarkMode() async {
    return await pre.getTheme();
  }
}

extension CustomColorSchemeX on ColorScheme {
  Color get gradientColor =>
      brightness == Brightness.light ? Colors.white : Colors.black;
}

/*
darkTheme: ThemeData(
    fontFamily: "NetflixSans",
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.black,
    cupertinoOverrideTheme: const CupertinoThemeData(
        barBackgroundColor: Color(0xFF1b1b1b),
        brightness: Brightness.dark,
        textTheme:
            CupertinoTextThemeData(primaryColor: Colors.white)),
    brightness: Brightness.dark),
*/
//theme data for each theme
ThemeData darkTheme = ThemeData(
  fontFamily: "NetflixSans",
  // useMaterial3: true,
  primaryColor: Colors.black,
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(const Color(0xFFE50914))),
  cardTheme: const CardTheme(surfaceTintColor: Color(0xff101820)),
  iconTheme: const IconThemeData(color: Color(0xffcfcfcf)),
  cupertinoOverrideTheme: const CupertinoThemeData(
      barBackgroundColor: Color(0xFF1b1b1b),
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(primaryColor: Colors.white)),
  appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle:
          const TextTheme(headline4: TextStyle(color: Colors.white)).headline4),
);

ThemeData lightTheme = ThemeData(
  fontFamily: "NetflixSans",
  switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(const Color(0xFFE50914))),
  // useMaterial3: true,
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white),
  ),
  primaryColor: const Color(0xFFE50914),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: Colors.white,
  cardTheme: const CardTheme(surfaceTintColor: Colors.white),
  // cupertinoOverrideTheme: const CupertinoThemeData(
  //     // barBackgroundColor: Color(0xFFE50914),
  //     brightness: Brightness.light,
  //     textTheme: CupertinoTextThemeData(primaryColor: Colors.white)),
  appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFE50914),
      surfaceTintColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle:
          const TextTheme(headline4: TextStyle(color: Colors.white)).headline4),
);
