import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fuzzysearch/fuzzysearch.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:provider/provider.dart';
import 'package:web_scraper/web_scraper.dart';
import '../models/models.dart';
import '../services/drift_database.dart';
import '../widgets/search_tiles.dart';
import '../widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubits.dart';
import '../data/data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ScrollController _scrollController;

  late Future<List<String?>> allSeries;
  late List<String> resultList;
  late List<Tile> tileList;

  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  final webScraper2 = WebScraper('https://bs.to');
  List<Map<String, dynamic>>? Tile_Img;
  String? imageUrl;

  @override
  void initState() {
    resultList = [""];
    tileList = [];
    tileList.add(Tile(name: 'Placeholder'));
    _scrollController = ScrollController()
      ..addListener(() {
        BlocProvider.of<AppBarCubit>(context)
            .setOffset(_scrollController.offset);
      });
    super.initState();
  }

  void SearchFuzz(String searchTerm) async {
    MyDatabase database = Provider.of<MyDatabase>(context, listen: false);
    // MyDatabase database = MyDatabase();
    List<String> allSers = await database.getAllSeriesTitles();
    final fuse = Fuzzy<Serie>(
      allSers,
      options: FuzzyOptions(
        maxPatternLength: 64,
        findAllMatches: true,
        tokenize: true,
        matchAllTokens: true,
        isCaseSensitive: false,
        threshold: 0.1,
        verbose: false,
        shouldSort: true,
      ),
    );
    Stopwatch stopwatch = Stopwatch()..start();
    final result = await fuse.search(searchTerm);
    // final result = extractTop(
    //   query: searchTerm,
    //   limit: 40,
    //   choices: await database.getAllSeriesTitles(),
    //   cutoff: 90,
    // );
    print(result);
    stopwatch.stop();
    resultList.clear();
    tileList.clear();
    int range = result.length <= 40 ? result.length - 1  : 40;
    for(var i = 0; i <= range; i++) {
      resultList.add(result[i].item);
      String? test = await database.getUrl(result[i].item);

      String? seriesName = test ?? "serie/Parallel-Worlds-Parallels";
      if (await webScraper2.loadWebPage("/$seriesName")) {
        setState(() {
          Tile_Img = webScraper2.getElement('div#sp_right > img', ['src']);
        });
        imageUrl = "https://bs.to" + Tile_Img?[0]["attributes"]["src"];
        //print("Ergebniss: $Tile_Img / Name: ${result[i].item} / Url: $test");
      }

      Tile tile = Tile(name: result[i].item, url: test, imageUrl: imageUrl);
      tileList.add(tile);
    }
    // result.forEach((r) async {
    //   resultList.add(r.item);
    //   String? test = await database.getUrl(r.item);
    //
    //   String? seriesName = test ?? "serie/Parallel-Worlds-Parallels";
    //   if (await webScraper2.loadWebPage("/$seriesName")) {
    //     setState(() {
    //       Tile_Img = webScraper2.getElement('div#sp_right > img', ['src']);
    //     });
    //      imageUrl = "https://bs.to" + Tile_Img?[0]["attributes"]["src"];
    //     //print("Ergebniss: $Tile_Img");
    //     //print(seriesName);
    //     //return "https://bs.to" + Tile_Img?[0]["attributes"]["src"];
    //   }
    //
    //   Tile tile = Tile(name: r.item, url: test, imageUrl: imageUrl);
    //   tileList.add(tile);
    // });

    print(
        "It matched ${result.length} in ${stopwatch.elapsedMilliseconds} ms.");
    // result.map((r) => r.output.first.value).forEach(print);
    // database.close();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: <Widget>[
        SizedBox(
          height: 70,
          child: Scaffold(
            // extendBodyBehindAppBar: false,
            body: Row(children: [
              if(Responsive.isDesktop(context)) IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed("/NavScreens");
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // Add padding around the search bar
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    // Use a Material design search bar
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        hintText: 'Search...',
                        // Add a clear button to the search bar
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => _searchController.clear(),
                        ),
                        // Add a search icon or button to the search bar
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          // onPressed: () => print("Test"),
                          onPressed: () {
                            // Perform the search here
                            //print("called1");
                            SearchFuzz(_searchController.text);
                            //print(resultList);
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onSubmitted: (value) {
                        SearchFuzz(value);
                      },
                      onChanged: (value) {
                        //SearchFuzz(value);
                      },
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        Expanded(
          child:  SearchTile(
              tileList: tileList,
            ),
          // child: Scaffold(
          //   body: ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: (resultList.length <= 20) ? resultList.length : 20,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         tileColor: Colors.blue,
          //         title: Text(
          //             resultList[index]
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ),
      ]),
    );
  }
}
//
// class SearchResults extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => SearchResultsState();
// }
//
// class SearchResultsState extends State<SearchResults> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Serie>?>(
//         //future: resultList,
//         builder: (context, snapshot) {
//       //var snapshot = snapshots.data?[0];
//       if (snapshot.hasError) {
//         return Text(
//           'There was an error :(',
//           style: Theme.of(context).textTheme.headline1,
//         );
//       } else if (snapshot.hasData) {
//         //var count = snapshot.data?.length;
//         //return Scraper(data: snapshot.data!);
//         return Expanded(
//           child: ListView.builder(
//              shrinkWrap: true,
//             itemCount: snapshot.data?.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 200,
//                 child: ListTile(
//                   title: Text(
//                     "${snapshot.data?[index].id}) ${snapshot.data?[index].title}",
//                     textDirection: TextDirection.ltr,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       } else {
//         return const SizedBox(
//           width: 200,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 50,
//                   height: 50,
//                   child: CircularProgressIndicator(
//                       backgroundColor: Colors.redAccent,
//                       valueColor: AlwaysStoppedAnimation(Colors.red)),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//     });
//   }
// }
