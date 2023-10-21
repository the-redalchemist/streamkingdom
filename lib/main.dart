import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamkingdom/cubits/cubits.dart';
import 'package:streamkingdom/services/SharedPrefsService.dart';
import 'package:streamkingdom/services/drift_database.dart';
import 'screens/screens.dart';
import 'package:streamkingdom/api/tmdb_calls.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'languages/locale_constant.dart';
import 'languages/localizations_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//void main() => runApp(const MaterialApp(home: WebScraperApp(), debugShowCheckedModeBanner: false));

Future<void> main() async{
  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://f4968657a848555b6ca4076f21c5a21c@o4505990744244224.ingest.sentry.io/4505990747717632';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppBarCubit()),
        Provider<MyDatabase>(
          create: (context) => MyDatabase(), //this makes the singleton database
          dispose: (context, MyDatabase db) => db.close(),
        ),
      ],
      child: MyApp(),
    )),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  static void setLocales(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  static void reloadAll(BuildContext context) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.reloadAlls();
  }
}

class _MyAppState extends State<MyApp> {
  final tmdb_call apiCall = tmdb_call();
  late final Future getAllSeriesFromBStoFuture;
  late final Future getTrendingFutureDay;
  late final Future getTrendingFutureWeek;
  late final Future getPopularsFuture;
  late final Future getHeaderDataFuture;
  late final Future getTest;

  // late Future<List<dynamic>> getOrderListActives;

  /// 1) our themeMode "state" field
  ThemeMode _themeMode = ThemeMode.system;

  late Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void reloadAlls() {
    setState(() {
      // _locale = _locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });

    getAllSeriesFromBStoFuture = apiCall.getAllSeriesFromBSto(
        database: Provider.of<MyDatabase>(context));
    getTrendingFutureDay =
        apiCall.getTrending(database: Provider.of<MyDatabase>(context));
    getTrendingFutureWeek = apiCall.getTrending(
        time: 'week', database: Provider.of<MyDatabase>(context));
    getPopularsFuture =
        apiCall.getPopular(database: Provider.of<MyDatabase>(context));
    getHeaderDataFuture =
        apiCall.getHeaderData(database: Provider.of<MyDatabase>(context));

    getTest =
        apiCall.getOrderListActives(database: Provider.of<MyDatabase>(context));

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: Future.wait([
          getAllSeriesFromBStoFuture,
          // getTrendingFutureDay,
          // getTrendingFutureWeek,
          // getPopularsFuture,
          getHeaderDataFuture,
          apiCall.getOrderListActives(database: Provider.of<MyDatabase>(context)),
        ]),
        builder: (context, AsyncSnapshot snapshot) {
          // future: Future<void>.delayed(const Duration(seconds: 2), () {});
          // var snapshot = snapshots.data?[0];
          if (snapshot.hasError) {
            print("Error: $snapshot.error");
            return MaterialApp(
              home: Text(
                'There was an error :(',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            // apiCall.closeDatabase();
            // print(snapshot.data?[1].length);
            // print(snapshot.data[2]);
            return MaterialApp(
                theme: Provider.of<ThemeProvider>(context).currentTheme,
                title: 'Stream Kingdom',
                debugShowCheckedModeBanner: false,
                locale: _locale,
                supportedLocales: const [Locale('en', ''), Locale('de', '')],
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode &&
                        supportedLocale.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },

                // themeMode: _themeMode,
                // darkTheme: ThemeData(
                //     fontFamily: "NetflixSans",
                //     primarySwatch: Colors.blue,
                //     visualDensity: VisualDensity.adaptivePlatformDensity,
                //     scaffoldBackgroundColor: Colors.black,
                //     cupertinoOverrideTheme: const CupertinoThemeData(
                //         barBackgroundColor: Color(0xFF1b1b1b),
                //         brightness: Brightness.dark,
                //         textTheme:
                //             CupertinoTextThemeData(primaryColor: Colors.white)),
                //     brightness: Brightness.dark),
                home: NavScreen(
                  // popularList: snapshot.data![2],
                  // trendingDayList: snapshot.data![2],
                  // trendingWeekList: snapshot.data![2],
                  headerContent: snapshot.data![1],
                  frontLists: snapshot.data![2],
                ),
                routes: <String, WidgetBuilder>{
                  // "/SearchScreens": (BuildContext context) => const SearchScreen(),
                  "/SearchScreens": (BuildContext context) => const NavScreen(
                        pageIndex: 1,
                      ),
                  "/HomeScreens": (BuildContext context) => const NavScreen(
                        pageIndex: 0,
                      ),
                  "/NavScreens": (context) => MyApp(),
                  "/Settings": (context) => const SettingsScreen(),
                });
          } else {
            // return const Center(child: AnimatedContainer());
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Center(
                  child: LoadingAnimationWidget.halfTriangleDot(
                size: 200,
                color: Colors.white,
              )),
            );
          }
        });
  }

  /// 3) Call this to change theme from any context using "of" accessor
  /// e.g.:
  /// MyApp.of(context).changeTheme(ThemeMode.dark);
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class AnimatedContainer extends StatefulWidget {
  const AnimatedContainer({super.key});

  @override
  _AnimatedContainer createState() => _AnimatedContainer();
}

class _AnimatedContainer extends State<AnimatedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 9000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 10, end: 2000).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    // _controller.repeat();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: _animation.value,
      height: _animation.value,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
