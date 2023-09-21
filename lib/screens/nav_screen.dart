import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:streamkingdom/languages/languages.dart';
import '../api/tmdb_calls.dart';
import '../cubits/cubits.dart';
import '../models/models.dart';
import '../screens/screens.dart';
import '../services/drift_database.dart';
import '../widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  final int? pageIndex;
  final List<Tile>? popularList;
  final List<Tile>? trendingDayList;
  final List<Tile>? trendingWeekList;
  final List<dynamic>? frontLists;
  final HeaderContent? headerContent;

  const NavScreen(
      {Key? key,
      this.pageIndex,
      this.popularList,
      this.trendingDayList,
      this.trendingWeekList,
      this.headerContent,
      this.frontLists})
      : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;
  late final Map<String, IconData> _icons;

  @override
  void initState() {
    _currentIndex = widget.pageIndex ?? 0;
    super.initState();

    // Future.delayed(Duration.zero, () {
    //   _icons = {
    //     'Home': Icons.home,
    //     Languages.of(context)!.searchLabel ?? "Search" : Icons.search,
    //     'Coming Soon': Icons.queue_play_next,
    //     // 'Downloads': Icons.file_download,
    //     Languages.of(context)!.settingsTitle: Icons.settings,
    //   };
    // });
  }

  late final List<Widget> _screens = [
    HomeScreen(
      key: const PageStorageKey('homeScreen'),
      popularList: widget.popularList,
      trendingDayList: widget.trendingDayList,
      trendingWeekList: widget.trendingWeekList,
      frontLists: widget.frontLists,
      headerContent: widget.headerContent,
    ),
    const SearchScreen(
      key: PageStorageKey('searchScreen'),
    ),
    const Scaffold(),
    const SettingsScreen(),
    // const Scaffold(),
  ];

  // final Map<String, IconData> _icons = {
  //   'Home': Icons.home,
  //   "Search" : Icons.search,
  //   'Coming Soon': Icons.queue_play_next,
  //   // 'Downloads': Icons.file_download,
  //   'Settings': Icons.settings,
  // };

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> _icons = {
      Languages.of(context)?.home ?? 'Home': Icons.home,
      Languages.of(context)?.searchLabel ?? "Search": Icons.search,
      'Coming Soon': Icons.queue_play_next,
      // 'Downloads': Icons.file_download,
      Languages.of(context)?.settingsTitle ?? 'Settings': Icons.settings,
    };
    return Scaffold(
        body: BlocProvider<AppBarCubit>(
          create: (context) => AppBarCubit(),
          child: _screens[_currentIndex],
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
                items: _icons
                    .map((title, icon) => MapEntry(
                        title,
                        BottomNavigationBarItem(
                          icon: Icon(
                            icon,
                            size: 30,
                          ),
                          label: title,
                        )))
                    .values
                    .toList(),
                currentIndex: _currentIndex,
                selectedItemColor: Colors.white,
                selectedFontSize: 11,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 11,
                onTap: (index) => setState(() => _currentIndex = index),
                // onTap: (index) => print(index),
              )
            : null);
  }
}
