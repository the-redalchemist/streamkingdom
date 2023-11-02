import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:streamkingdom/services/drift_database.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';
import '../services/SharedPrefsService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class tmdb_call {
  final endpoint = 'https://api.themoviedb.org/3';
  final apiKey = '5afee2c6583b6622dc0ebeb09f463bc7';
  final webScraper2 = WebScraper('https://bs.to');
  bool seriesSyncComp = false;
  bool listSyncComplete = false;
  List<String>? orderListActives;

  Future<List<dynamic>> getOrderListActives({database}) async {
    Stopwatch stopwatch = Stopwatch()
      ..start();
    List<dynamic> returnList = [];
    SavePreference pre = SavePreference();
    orderListActives = await pre.getOrderListActive();
    print(orderListActives);
    if (orderListActives == null) {
      orderListActives = [];
      orderListActives?.add("Popular");
      orderListActives?.add("TrendingDay");
      orderListActives?.add("TrendingWeek");
      pre.setOrderListActive(orderListActives!);
    }

    Future getTrendingFutureDay;
    Future getTrendingFutureWeek;
    Future getPopularsFuture;
    List<Future> futureList = [];
    for (var element in orderListActives!) {
      switch (element) {
        case "Popular":
          getPopularsFuture = getPopular(database: database);
          futureList.add(getPopularsFuture);
          //returnList.add({'title': "Popular", 'value': getPopular(database: database)});
          break;
        case "TrendingDay":
          getTrendingFutureDay = getTrending(database: database);
          futureList.add(getTrendingFutureDay);
          //returnList.add({'title': "Trending day", 'value': getTrending(database: database)});
          break;
        case "TrendingWeek":
          getTrendingFutureWeek = getTrending(time: "week", database: database);
          futureList.add(getTrendingFutureWeek);
          //returnList.add({'title': "Trending week", 'value': getTrending(time: "week", database: database)});
          break;
      }
    }
    await Future
        .wait(futureList)
        .then((List responses) {
          print("then wurde erreicht");
          for (int i = 0; i < orderListActives!.length; i++) {
            returnList.add({'title': orderListActives?[i], 'value': responses[i]});
          }
    });

    print(
        "It took ${stopwatch.elapsedMilliseconds} ms / ${stopwatch
            .elapsed} to sync all Lists");
    Fluttertoast.showToast(
        msg: "It took ${stopwatch.elapsedMilliseconds} ms / ${stopwatch.elapsed} to sync all Lists",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return returnList;
  }

  Future<HeaderContent> getHeaderData({database}) async {
    print("we are inside headerData");
    if (await database.checkForLastSync("header")) {
      print("already have header data");
      return await database.getHeader();
    } else {
      await waitWhile(() => listSyncComplete);
      Random random = Random();
      int randomNumber1 = random.nextInt(orderListActives!.length);
      ListContent tile = await database.getRandomTile(orderListActives![randomNumber1]);
      List<Map<String, dynamic>>? Tile_desc;
      if (await webScraper2.loadWebPage("/${tile.url}")) {
        Tile_desc = webScraper2.getElement('div#sp_left > p', ['']);
        // print(Tile_desc[0]['title']);
        // header.description = Tile_desc[0]['title'];
      }
      HeaderContent header = HeaderContent(
          title: tile.name,
          imageUrl: tile.imageUrl!,
          url: tile.url,
          description: (Tile_desc?[0]['title'] ?? "Lorem ipsum"),
          posterUrl: tile.backdropPath!);

      return await database.addHeader(header);
    }
  }

  Future<List<Tile>> getTrending(
      {lang = 'de-DE', type = 'tv', time = 'day', database}) async {
    await waitWhile(() => seriesSyncComp);
    String Day_Week = time == "day" ? "trendingDays" : "trendingWeeks";
    if (await database.checkForLastSync(Day_Week)) {
      print("already have trending $time");
      listSyncComplete = true;
      if (time == "day") {
        return await database.getApiCallsFromDb("trendingDays");
      } else {
        return await database.getApiCallsFromDb("trendingWeeks");
      }
    } else {
      Stopwatch stopwatch = Stopwatch()
        ..start();
      // MyDatabase database2 = MyDatabase();
      final List<Tile> tileList = [];
      final List<ListContent> trendingList = [];
      List<Map<String, dynamic>>? Tile_Img;
      String? imageUrl;
      //List<String> allSers = await database.getAllSeriesTitles();
      final fuse = Fuzzy<Serie>(
        await database.getAllSeriesTitles() as List<String>,
        options: FuzzyOptions(
          findAllMatches: false,
          tokenize: true,
          matchAllTokens: true,
          isCaseSensitive: false,
          threshold: 0.2,
          verbose: true,
          shouldSort: true,
        ),
      );
      var result = await http.get(Uri.parse(
          '$endpoint/trending/$type/$time?api_key=$apiKey&language=$lang'));
      var body = jsonDecode(result.body);
      // print(body);
      for (var e
      in List.castFrom<dynamic, Map<String, dynamic>>(body['results'])) {
        // print("trending test ${e['name']}");
        // String? test =
        //     await database.getUrl(e['name']) ?? "serie/Parallel-Worlds-Parallels";
        String? test = await database.getUrl(e['name']);
        // if(e['name'] == "Twisted Metal") {
        //   test = "serie/Twisted";
        // }
        String backdrop_path = "https://image.tmdb.org/t/p/original${e['backdrop_path']}";
        if (test == null) {
          // e['name'].runes.forEach((int rune) {
          //
          // });
          // print("test ist null ${e['name']} / $allSers");
          // final result = extractTop(
          //   query: e['name'],
          //   limit: 1,
          //   choices: allSers,
          //   cutoff: 90,
          // );
          final result = await fuse.search(e['name']);
          // final result = null;
          // print("result $result");
          if (result.isEmpty) {
            test = null;
          } else {
            test = await database.getUrl(result[0].item);
          }
        }
        // print("blabla $test");
        if (test == null) {
          final result = await fuse.search(firstWordWithoutThe(e['name']));
          // final result = extractTop(
          //   query: getFirstWords(e['name'], 1),
          //   limit: 1,
          //   choices: allSers,
          //   cutoff: 90,
          // );
          if (result.isEmpty) {
            test = null;
          } else {
            test = await database.getUrl(result[0].item);
          }
        }
        if (test == null) {
          imageUrl = "https://bs.to/public/images/default-cover.jpg";
        } else {
          if (await webScraper2.loadWebPage("/$test")) {
            Tile_Img = webScraper2.getElement('div#sp_right > img', ['src']);
            imageUrl = "https://bs.to" + Tile_Img[0]["attributes"]["src"];
            print(
                "Trending $time, Ergebniss: $Tile_Img / Name: ${e['name']} / Url: $test");
          }
          // print(e);
          Tile tile = Tile(name: e["name"], url: test, imageUrl: imageUrl);
          ListContent trending = ListContent(name: e["name"],
              url: test,
              imageUrl: imageUrl,
              backdropPath: backdrop_path);
          trendingList.add(trending);
          tileList.add(tile);
        }
      }
      // database.close();
      if (time == 'week') {
        //database.addTrendingWeek(tileList);
        await database.addTrendingWeek(trendingList);
      } else if (time == 'day') {
        await database.addTrendingDay(trendingList);
        //database.addTrendingDay(tileList);
      }
      stopwatch.stop();
      print(
          "It took ${stopwatch.elapsedMilliseconds} ms / ${stopwatch
              .elapsed} to sync trending $time");
      listSyncComplete = true;
      return tileList;
    }
  }

  Future<List<Tile>> getPopular(
      {lang = 'de-DE', region = 'CH', database}) async {
    await waitWhile(() => seriesSyncComp);
    //print("getPopular was called");
    //listSyncComplete = false;
    if (await database.checkForLastSync("popular")) {
      print("already have populars");
      listSyncComplete = true;
      return await database.getApiCallsFromDb("popular");
    } else {
      Stopwatch stopwatch = Stopwatch()
        ..start();
      // MyDatabase database2 = MyDatabase();
      final List<Tile> tileList = [];
      final List<ListContent> popularList = [];
      List<Map<String, dynamic>>? Tile_Img;
      String? imageUrl;
      final fuse = Fuzzy<Serie>(
        await database.getAllSeriesTitles() as List<String>,
        options: FuzzyOptions(
          findAllMatches: true,
          tokenize: true,
          matchAllTokens: true,
          isCaseSensitive: false,
          threshold: 0.2,
          verbose: false,
          shouldSort: true,
        ),
      );
      var result = await http.get(Uri.parse(
          '$endpoint/discover/tv?api_key=$apiKey&language=$lang&page=1&sort_by=popularity.desc&watch_region=$region&with_runtime.gte=0&with_runtime.lte=400&with_watch_monetization_types=flatrate%7Cfree%7Cads%7Crent%7Cbuy&include_adult=true&vote_count.gte=50'));
      var body = jsonDecode(result.body);
      // print(body);
      for (var e
      in List.castFrom<dynamic, Map<String, dynamic>>(body['results'])) {
        // String? test =
        //     await database.getUrl(e['name']) ?? "serie/Parallel-Worlds-Parallels";
        String? test = await database.getUrl(e['name']);
        String backdrop_path = "https://image.tmdb.org/t/p/original${e['backdrop_path']}";
        if (test == null) {
          // e['name'].runes.forEach((int rune) {
          //
          // });
          final result = await fuse.search(e['name']);
          if (result.isEmpty) {
            test = null;
          } else {
            test = await database.getUrl(result[0].item);
          }
        }
        if (test == null) {
          final result = await fuse.search(firstWordWithoutThe(e['name']));
          if (result.isEmpty) {
            test = null;
          } else {
            test = await database.getUrl(result[0].item);
          }
        }
        if (test == null) {
          imageUrl = "https://bs.to/public/images/default-cover.jpg";
          print("Removed ${e['name']}");
        } else {
          if (await webScraper2.loadWebPage("/$test")) {
            Tile_Img = webScraper2.getElement('div#sp_right > img', ['src']);
            imageUrl = "https://bs.to" + Tile_Img[0]["attributes"]["src"];
            print(
                "Popular Ergebniss: $Tile_Img / Name: ${e['name']} / Url: $test");
          }
          // print(e);
          Tile tile = Tile(name: e["name"], url: test, imageUrl: imageUrl);
          ListContent popular = ListContent(name: e["name"],
              url: test,
              imageUrl: imageUrl,
              backdropPath: backdrop_path);
          popularList.add(popular);
          tileList.add(tile);
        }
      }
      await database.addPopular(popularList);
      // database.close();
      stopwatch.stop();
      print(
          "It took ${stopwatch.elapsedMilliseconds} ms / ${stopwatch
              .elapsed} to sync most popular");
      listSyncComplete = true;
      return tileList;
    }
  }

  String firstWordWithoutThe(String bigsentence) {
    if (!equalsIgnoreCase(getFirstWords(bigsentence, 1), "The")) {
      return getFirstWords(bigsentence, 1);
    }

    int startindex = 0;
    int indexofspace = 0;

    for (int i = 0; i < 2; i++) {
      indexofspace = bigsentence.indexOf(' ', startindex);
      if (indexofspace == -1) {
        //-1 is when character is not found
        return bigsentence;
      }
      startindex = indexofspace + 1;
    }

    return bigsentence
        .substring(4, indexofspace)
        .replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  String getFirstWords(String sentence, int wordCounts) {
    return sentence.split(" ").sublist(0, wordCounts).join(" ");
  }

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  Future<void> getAllSeriesFromBSto({database}) async {
    if (await database.checkForLastSync("allSeries")) {
      // print("wuhu alle serien sind bereits vorhanden");
      seriesSyncComp = true;
    } else {
      seriesSyncComp = false;
      Stopwatch stopwatch = Stopwatch()
        ..start();
      List<Map<String, dynamic>>? seriesList;
      if (await webScraper2.loadWebPage('/andere-serien')) {
        seriesList = webScraper2.getElement(
            'div#seriesContainer > div.genre > ul > li > a', ['href']);
        //print(seriesList);
      }
      await database.addSeries(seriesList!);
      stopwatch.stop();
      print(
          "It took ${stopwatch.elapsedMilliseconds} ms / ${stopwatch
              .elapsed} to sync all series");
      seriesSyncComp = true;
    }
  }

  Future waitWhile(bool test(), [Duration pollInterval = Duration.zero]) {
    var completer = Completer();
    check() {
      if (test()) {
        print("its true: $test");
        completer.complete();
      } else {
        //print("its false: $seriesSyncComp");
        Timer(pollInterval, check);
      }
    }

    check();
    return completer.future;
  }

  Future<bool> getDarkmode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? repeat = prefs.getBool('darkMode');

    if (repeat != null) {
      return repeat;
    } else {
      await prefs.setBool('darkMode', true);
    }
    return true;
  }
}
