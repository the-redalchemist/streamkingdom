import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:streamkingdom/models/language_data.dart';
import 'dart:io' show Platform;

import '../cubits/app_bar/ThemeProvider.dart';
import '../languages/languages.dart';
import '../languages/locale_constant.dart';
import '../main.dart';
import '../services/SharedPrefsService.dart';
import '../services/navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkTheme = true;
  bool testBool = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Languages.of(context)?.settingsTitle ?? "Settings"),
      ),
      body: SafeArea(
        bottom: false,
        child: SettingsList(
          // applicationType: ApplicationType.both,
          platform:
              (Platform.isWindows) ? DevicePlatform.web : DevicePlatform.device,
          sections: [
            SettingsSection(
              title: Text(Languages.of(context)?.appearance ?? "Appearance"),
              tiles: [
                SettingsTile.switchTile(
                  onToggle: (value) {
                    setState(() {
                      darkTheme = value;
                      context.read<ThemeProvider>().changeCurrentTheme(value);
                      if (value) {
                        // MyApp.of(context).changeTheme(ThemeMode.dark);
                      } else {
                        // MyApp.of(context).changeTheme(ThemeMode.light);
                      }
                    });
                  },
                  initialValue: darkTheme =
                      (Provider.of<ThemeProvider>(context).currentTheme ==
                              lightTheme)
                          ? false
                          : true,
                  // initialValue: darkTheme = (context.read<ThemeProvider>().currentTheme == lightTheme) ? false : true,
                  activeSwitchColor:
                      (Provider.of<ThemeProvider>(context).currentTheme ==
                              lightTheme)
                          ? const Color(0xFFE50914)
                          : const Color(0xFFE50914),
                  title: Text(
                      Languages.of(context)?.darkMode ?? 'Dark Appearance'),
                  // activeSwitchColor: const Color(0xFFE50914),
                ),
              ],
            ),
            SettingsSection(
              title: Text(Languages.of(context)?.language ?? 'Language'),
              tiles: [
                SettingsTile.navigation(
                  leading: const Icon(Icons.language),
                  title: Text(Languages.of(context)?.languages ?? 'Languages'),
                  onPressed: (context) async {
                    final platform = await Navigation.navigateTo<LanguageData>(
                      context: context,
                      style: NavigationRouteStyle.cupertino,
                      screen: const LanguagePickerScreen(
                          // language: LanguageData,
                          // languages: LanguageData.languageList(),
                          ),
                    );

                    if (platform != null) {
                      setState(() {
                        // selectedPlatform = platform;
                      });
                    }
                  },
                  // value: Text(platformsMap[selectedPlatform]!),
                ),
              ],
            ),
            SettingsSection(
              // title: Text(Languages.of(context)?.language ?? 'Language'),
              title: Text(Languages.of(context)?.order ?? 'Order'),
              tiles: [
                SettingsTile.navigation(
                  title: Text(Languages.of(context)?.order ?? 'Order'),
                  onPressed: (context) async {
                    final orderPage = await Navigation.navigateTo(
                      context: context,
                      style: NavigationRouteStyle.material,
                      screen: const HomeOrderScreen(
                          // language: LanguageData,
                          // languages: LanguageData.languageList(),
                          ),
                    );

                    if (orderPage != null) {
                      setState(() {
                        // selectedPlatform = platform;
                      });
                    }
                  },
                  // value: Text(platformsMap[selectedPlatform]!),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LanguagePickerScreen extends StatelessWidget {
  const LanguagePickerScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(Languages.of(context)?.languages ?? 'Languages')),
      body: SettingsList(
        platform:
            (Platform.isWindows) ? DevicePlatform.web : DevicePlatform.device,
        sections: [
          SettingsSection(
            title: Text(Languages.of(context)?.selectLanguages ??
                'Select the Language you want'),
            tiles: LanguageData.languageList().map((e) {
              return SettingsTile(
                leading: Text(e.flag),
                title: Text(e.name),
                onPressed: (_) {
                  changeLanguage(context, e.languageCode);
                  // Navigator.of(context).pop(e);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class HomeOrderScreen extends StatefulWidget {
  const HomeOrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeOrderScreen> createState() => _HomeOrderScreenState();
}

class _HomeOrderScreenState extends State<HomeOrderScreen> {
  final List<String> _list = ["Popular", "TrendingDay", "TrendingWeek"];
  List<String> savebleActiveList = ["Popular", "TrendingDay", "TrendingWeek"];
  List<String> savebleInactiveList = [];
  late List<DragAndDropList> _contents;

  String getTranslatedString(String input) {
    switch (input) {
      case "Popular":
        return Languages.of(context)?.popularTitle ?? "Popular";
      case "TrendingDay":
        return Languages.of(context)?.trendingDayTitle ?? "TrendingDay";
      case "TrendingWeek":
        return Languages.of(context)?.trendingWeekTitle ?? "TrendingWeek";
    }
    return "Unknown";
  }

  Future<List<DragAndDropList>> buildDragAndDropList() async {
    SavePreference pre = SavePreference();
    List<String>? orderListActives = await pre.getOrderListActive();
    List<String>? orderListInactives = await pre.getOrderListInactive();

    if (orderListActives != null) {
      savebleActiveList = orderListActives;
    }
    if (orderListInactives != null) {
      savebleInactiveList = orderListInactives;
    }

    orderListActives ??= _list;
    orderListInactives ??= [];
    final List<DragAndDropItem> itemsList = [];
    for (var element in orderListActives) {
      itemsList.add(DragAndDropItem(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                getTranslatedString(element),
              ),
            ),
          ],
        ),
      ));
    }

    final List<DragAndDropItem> itemsInactiveList = [];
    for (var element in orderListInactives) {
      itemsInactiveList.add(DragAndDropItem(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                getTranslatedString(element),
              ),
            ),
          ],
        ),
      ));
    }

    final List<DragAndDropList> contentsList = [
      DragAndDropList(
        canDrag: false,
        contentsWhenEmpty:
            Text(Languages.of(context)?.emptyList ?? "Nothing here"),
        header: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    Languages.of(context)?.activeList ?? "Active",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: itemsList,
      ),
      DragAndDropList(
        canDrag: false,
        contentsWhenEmpty:
            Text(Languages.of(context)?.emptyList ?? "Nothing here"),
        header: Column(
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    Languages.of(context)?.inactiveList ?? "Hidden",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: itemsInactiveList,
      )
    ];
    return contentsList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: buildDragAndDropList(),
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
          // print(snapshot.data);
          _contents = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  if (checkIfActiveListEmpty()) {
                    MyApp.reloadAll(context);
                    Navigator.of(context).pop();
                  } else {
                    print("nope its empty");
                    showAlertDialog(context);
                  }
                },
              ),
              title: const Text('Drag Handle'),
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.save),
              //     tooltip: 'Save',
              //     onPressed: () {
              //       MyApp.reloadAll(context);
              //     },
              //   ),
              // ],
            ),
            body: DragAndDropLists(
              children: _contents,
              onItemReorder: _onItemReorder,
              onListReorder: _onListReorder,
              onItemAdd: _onItemAdd,
              onListAdd: _onListAdd,
              listPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemDivider: const Divider(
                thickness: 2,
                height: 2,
              ),
              itemDecorationWhileDragging: BoxDecoration(
                // color: Colors.white,
                // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              listInnerDecoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              lastItemTargetHeight: 8,
              addLastItemTargetHeightToTop: true,
              lastListTargetSize: 40,
              itemDragHandle: const DragHandle(
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
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
      },
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      if (oldListIndex == 0 && _contents[oldListIndex].children.length <= 1) {
        showAlertDialog(context);
      } else {
        var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
        _contents[newListIndex].children.insert(newItemIndex, movedItem);
        String movedString;
        if (oldListIndex == 0) {
          movedString = savebleActiveList.removeAt(oldItemIndex);
        } else {
          movedString = savebleInactiveList.removeAt(oldItemIndex);
        }
        if (newListIndex == 0) {
          savebleActiveList.insert(newItemIndex, movedString);
        } else {
          savebleInactiveList.insert(newItemIndex, movedString);
        }
        SavePreference pre = SavePreference();
        pre.setOrderListActive(savebleActiveList);
        pre.setOrderListInactive(savebleInactiveList);
      }
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }

  _onItemAdd(DragAndDropItem newItem, int listIndex, int itemIndex) {
    setState(() {
      if (itemIndex == -1) {
        _contents[listIndex].children.add(newItem);
      } else {
        _contents[listIndex].children.insert(itemIndex, newItem);
      }
    });
  }

  _onListAdd(DragAndDropListInterface newList, int listIndex) {
    setState(() {
      if (listIndex == -1) {
        _contents.add(newList as DragAndDropList);
      } else {
        _contents.insert(listIndex, newList as DragAndDropList);
      }
    });
  }

  bool checkIfActiveListEmpty() {
    // print(savebleActiveList);
    if (savebleActiveList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Waring"),
    content: const Text("You need to leave one at min."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
