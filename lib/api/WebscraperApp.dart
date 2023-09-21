import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:streamkingdom/services/drift_database.dart';

class WebScraperApp extends StatefulWidget {
  const WebScraperApp({super.key});

  @override
  _WebScraperAppState createState() => _WebScraperAppState();
}

class _WebScraperAppState extends State<WebScraperApp> {
  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://bs.to');
  MyDatabase database = MyDatabase();

  // Response of getElement is always List<Map<String, dynamic>>
  List<Map<String, dynamic>>? productNames;
  late Future<List<Map<String, dynamic>>?> productLinks;

  void fetchProducts() async {
    // Loads web page and downloads into local state of library
    if (await webScraper.loadWebPage('/andere-serien')) {
      setState(() {
        productNames = webScraper.getElement(
            'div#seriesContainer > div.genre > ul > li > a', ['href']);
      });
      //print(productNames)
    }
    database.addSeries(productNames!);
  }

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Serie>?>(
        future: database.getAllSeries(),
        builder: (context, snapshot) {
          //var snapshot = snapshots.data?[0];
          if (snapshot.hasError) {
            return Text(
              'There was an error :(',
              style: Theme.of(context).textTheme.headline1,
            );
          } else if (snapshot.hasData) {
            //var count = snapshot.data?.length;
            //return Scraper(data: snapshot.data!);
            return Scaffold(
                body: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${snapshot.data?[index].id}) ${snapshot.data?[index].title}", textDirection: TextDirection.ltr,),
                    );
                  },
                )
            );
          }  else {
            return const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.redAccent,
                          valueColor: AlwaysStoppedAnimation(Colors.red)),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}