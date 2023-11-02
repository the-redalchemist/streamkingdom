import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:streamkingdom/models/models.dart';
import 'dart:math';

part 'drift_database.g.dart';

//Run "dart run build_runner build" if tables get adjusted.

class Series extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get link => text()();

//@override
//Set<Column> get primaryKey => {id, title};
}

class Populars extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get link => text()();

  TextColumn get imgLink => text()();

  TextColumn get backdropUrl => text()();

//@override
//Set<Column> get primaryKey => {id, title};
}

class TrendingDays extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get link => text()();

  TextColumn get imgLink => text()();

  TextColumn get backdropUrl => text()();

//@override
//Set<Column> get primaryKey => {id, title};
}

class TrendingWeeks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get link => text()();

  TextColumn get imgLink => text()();

  TextColumn get backdropUrl => text()();

//@override
//Set<Column> get primaryKey => {id, title};
}

class LastSynced extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Slugs: popular , trendingDays , trendingWeeks , allSeries
  TextColumn get kind => text().unique()();

  DateTimeColumn get time => dateTime()();
}

class Headers extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get imgLink => text()();

  TextColumn get description => text()();

  TextColumn get url => text()();

  TextColumn get backdropUrl => text()();
}

@DriftDatabase(tables: [
  Series,
  Populars,
  TrendingDays,
  TrendingWeeks,
  LastSynced,
  Headers
])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  Future<void> addSeries(List<Map<String, dynamic>> series_param) async {
    //final database = MyDatabase();
    await delete(series).go();
    await customStatement("DELETE FROM sqlite_sequence WHERE NAME='series'");
    await batch((batch) {
      for (var element in series_param) {
        batch.insert(
            series,
            SeriesCompanion.insert(
                title: element['title'], link: element['attributes']['href']));
      }
    });
    // print(series_param);
    addApiCallTime("allSeries");
    // print("allSeries checkpoint");
    // Simple insert:
    /*await database
        .into(database.series)
        .insert(SeriesCompanion.insert(title: "tt", link: 'tt'));
*/
    // Simple select:
    //final allCategories = await database.select(database.categories).get();
    //print('Categories in database: $allCategories');
  }

  Future<List<Serie>?> getAllSeries() async {
    //final database = MyDatabase();
    final List<Serie> maps = await select(series).get();
    //await select(series).get();
    if (maps.isEmpty) {
      return null;
    }
    //print(maps);
    return maps;
  }

  Future<HeaderContent> getHeader() async {
    //final database = MyDatabase();
    final Header maps = await select(headers).getSingle();
    HeaderContent headerContent = HeaderContent(title: maps.title, imageUrl: maps.imgLink, url: maps.url, description: maps.description, posterUrl: maps.backdropUrl);
    return headerContent;
  }

  Future<HeaderContent> addHeader(HeaderContent headerEntity) async {
    print("here we add header to db");
    await delete(headers).go();
    await customStatement("DELETE FROM sqlite_sequence WHERE NAME='headers'");
    await into(headers).insert(HeadersCompanion(
        title: Value(headerEntity.title),
        imgLink: Value(headerEntity.imageUrl),
        description: Value(headerEntity.description!),
        url: Value(headerEntity.url!), backdropUrl: Value(headerEntity.posterUrl)));
    await addApiCallTime("header");
    return headerEntity;
  }

  Future<List<String>> getAllSeriesTitles() async {
    //final database = MyDatabase();
    final query = selectOnly(series)..addColumns([series.title]);
    var maps = query.map((row) => row.read(series.title).toString()).get();
    //await select(series).get();
    // if (maps.isEmpty) {
    //   return null;
    // }
    //print(maps);
    return maps;
  }

  Future<String?> getUrl(String name) async {
    final query = selectOnly(series)
      ..addColumns([series.link])
      ..where(series.title.equals(name));
    var maps = await query.map((row) => row.read(series.link).toString()).get();
    //await select(series).get();
    // if (maps.isEmpty) {
    //   return null;
    // }
    //print(maps);
    for (var i in maps) {
      //print("test ${i}");
      return i;
    }
    return null;
  }

  Future<void> addPopular(List<ListContent> tileList) async {
    await delete(populars).go();
    await customStatement("DELETE FROM sqlite_sequence WHERE NAME='populars'");
    await batch((batch) {
      for (var element in tileList) {
        batch.insert(
            populars,
            PopularsCompanion.insert(
                title: element.name,
                link: element.url!,
                imgLink: element.imageUrl!,
                backdropUrl: element.backdropPath!));
      }
    });
    await addApiCallTime("popular");
  }

  Future<void> addTrendingDay(List<ListContent> tileList) async {
    await delete(trendingDays).go();
    await customStatement(
        "DELETE FROM sqlite_sequence WHERE NAME='trendingDays'");
    await batch((batch) {
      for (var element in tileList) {
        batch.insert(
            trendingDays,
            TrendingDaysCompanion.insert(
                title: element.name,
                link: element.url!,
                imgLink: element.imageUrl!,
                backdropUrl: element.backdropPath!));
      }
    });
    await addApiCallTime("trendingDays");
  }

  Future<void> addTrendingWeek(List<ListContent> tileList) async {
    await delete(trendingWeeks).go();
    await customStatement(
        "DELETE FROM sqlite_sequence WHERE NAME='trendingWeeks'");
    await batch((batch) {
      for (var element in tileList) {
        batch.insert(
            trendingWeeks,
            TrendingWeeksCompanion.insert(
                title: element.name,
                link: element.url!,
                imgLink: element.imageUrl!,
                backdropUrl: element.backdropPath!));
      }
    });
    await addApiCallTime("trendingWeeks");
  }

  Future<void> addApiCallTime(String name) async {
    final entity = LastSyncedCompanion(
      kind: Value(name),
      time: Value(DateTime.now()),
    );
    // print(entity);
    // await into(lastSynced).insertOnConflictUpdate(entity)
    await into(lastSynced).insert(entity,
        onConflict: DoUpdate((old) => entity, target: [lastSynced.kind]));
  }

  //this returns true if it was synced in today already and false if you need to sync with api
  Future<bool> checkForLastSync(String name) async {
    switch (name) {
      case "popular":
        var baum = await customSelect(
            "SELECT count(*) FROM (select 0 from populars limit 1);",
            readsFrom: {populars}).get();
        print(baum[0].data.values.first);
        if (baum[0].data.values.first == null ||
            baum[0].data.values.first == 0) {
          // print("populars was empty: ${baum[0].data.values.first.toString()}");
          return false;
        }
        break;
      case "trendingDays":
        var baum = await customSelect(
            "SELECT count(*) FROM (select 0 from trending_days limit 1);",
            readsFrom: {trendingDays}).get();
        // print(baum[0].data.values.first);
        if (baum[0].data.values.first == null ||
            baum[0].data.values.first == 0) {
          print("trendingDays was empty");
          return false;
        }
        break;
      case "trendingWeeks":
        var baum = await customSelect(
            "SELECT count(*) FROM (select 0 from trending_weeks limit 1);",
            readsFrom: {trendingWeeks}).get();
        if (baum[0].data.values.first == null ||
            baum[0].data.values.first == 0) {
          print("trendingWeeks was empty");
          return false;
        }
        break;
      case "allSeries":
        var baum = await customSelect(
            "SELECT count(*) FROM (select 0 from series limit 1);",
            readsFrom: {series}).get();
        // print(baum[0].data.values.first);
        if (baum[0].data.values.first == null ||
            baum[0].data.values.first == 0) {
          print("allSeries was empty");
          return false;
        }
        break;
      case "header":
        var baum = await customSelect(
            "SELECT count(*) FROM (select 0 from headers limit 1);",
            readsFrom: {headers}).get();
        // print(baum[0].data.values.first);
        if (baum[0].data.values.first == null ||
            baum[0].data.values.first == 0) {
          print("header was empty");
          return false;
        }
        break;
    }

    final query = selectOnly(lastSynced)
      ..addColumns([lastSynced.time])
      ..where(lastSynced.kind.equals(name));
    var maps = await query.map((row) => row.read(lastSynced.time)).get();
    DateTime now = DateTime.now();
    print("test befor maps");
    print("maps: " + maps.isEmpty.toString());
    if (name == "header") {
      print(DateTime(maps[0]!.year, maps[0]!.month, maps[0]!.day, maps[0]!.hour, maps[0]!.minute));
      print(DateTime(now.year, now.month, now.day, now.hour, now.minute));
      print(DateTime(maps[0]!.year, maps[0]!.month, maps[0]!.day, maps[0]!.hour, maps[0]!.minute)
          .difference(DateTime(now.year, now.month, now.day, now.hour, now.minute))
          .inMinutes);
      if (maps.isEmpty ||
          DateTime(maps[0]!.year, maps[0]!.month, maps[0]!.day, maps[0]!.hour)
                  .difference(DateTime(now.year, now.month, now.day, now.hour))
                  .inHours <=
              0) {
        print("you need to call your api for header ");
        return false;
      }
    } else {
      if (maps.isEmpty ||
          DateTime(maps[0]!.year, maps[0]!.month, maps[0]!.day)
                  .difference(DateTime(now.year, now.month, now.day))
                  .inDays <
              0) {
        print("you need to call your api");
        return false;
      }
    }
    return true;
  }

  Future<List<Tile>> getApiCallsFromDb(String name) async {
    final List<Tile> tileList = [];
    switch (name) {
      case "popular":
        final List<dynamic> maps = await select(populars).get();
        for (var e in maps) {
          // print("Baum" + e.title);
          Tile tile = Tile(name: e.title, url: e.link, imageUrl: e.imgLink);
          tileList.add(tile);
        }
        break;
      case "trendingDays":
        final List<dynamic> maps = await select(trendingDays).get();
        for (var e in maps) {
          // print("Baum" + e.title);
          Tile tile = Tile(name: e.title, url: e.link, imageUrl: e.imgLink);
          tileList.add(tile);
        }
        break;
      case "trendingWeeks":
        final List<dynamic> maps = await select(trendingWeeks).get();
        for (var e in maps) {
          // print("Baum" + e.title);
          Tile tile = Tile(name: e.title, url: e.link, imageUrl: e.imgLink);
          tileList.add(tile);
        }
        break;
      case "allSeries":
        final List<dynamic> maps = await select(series).get();
        for (var e in maps) {
          // print("Baum" + e.title);
          Tile tile = Tile(name: e.title, url: e.link, imageUrl: e.imgLink);
          tileList.add(tile);
        }
        break;
    }

    return tileList;
  }

  Future<ListContent> getRandomTile(String listName) async {
    final List<ListContent> tileList = [];
    switch (listName) {
      case "Popular":
        var countExp = populars.id.count();
        final query = selectOnly(populars)..addColumns([countExp]);
        var result = await query.map((row) => row.read(countExp)).getSingle();
        Random random = Random();
        int randomNumber1 = random.nextInt(result! + 1);
        final dynamic maps = await (select(populars)
          ..where((t) => t.id.equals(randomNumber1)))
            .getSingle();
        ListContent tile = ListContent(name: maps.title, url: maps.link, imageUrl: maps.imgLink, backdropPath: maps.backdropUrl);
        tileList.add(tile);
        break;
      case "TrendingDay":
        var countExp = trendingDays.id.count();
        final query = selectOnly(trendingDays)..addColumns([countExp]);
        var result = await query.map((row) => row.read(countExp)).getSingle();
        Random random = Random();
        int randomNumber1 = random.nextInt(result! + 1);
        final dynamic maps = await (select(trendingDays)
          ..where((t) => t.id.equals(randomNumber1)))
            .getSingle();
        ListContent tile = ListContent(name: maps.title, url: maps.link, imageUrl: maps.imgLink, backdropPath: maps.backdropUrl);
        tileList.add(tile);
        break;
      case "TrendingWeek":
        var countExp = trendingWeeks.id.count();
        final query = selectOnly(trendingWeeks)..addColumns([countExp]);
        var result = await query.map((row) => row.read(countExp)).getSingle();
        Random random = Random();
        int randomNumber1 = random.nextInt(result! + 1);
        final dynamic maps = await (select(trendingWeeks)
          ..where((t) => t.id.equals(randomNumber1)))
            .getSingle();
        ListContent tile = ListContent(name: maps.title, url: maps.link, imageUrl: maps.imgLink, backdropPath: maps.backdropUrl);
        tileList.add(tile);
        break;
      default:
        var countExp = populars.id.count();
        final query = selectOnly(populars)..addColumns([countExp]);
        var result = await query.map((row) => row.read(countExp)).getSingle();
        Random random = Random();
        int randomNumber1 = random.nextInt(result! + 1);
        final dynamic maps = await (select(populars)
          ..where((t) => t.id.equals(randomNumber1)))
            .getSingle();
        ListContent tile = ListContent(name: maps.title, url: maps.link, imageUrl: maps.imgLink, backdropPath: maps.backdropUrl);
        tileList.add(tile);
        break;
    }
    return tileList[0];
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db2.sqlite'));
    // print(dbFolder.path);
    return NativeDatabase.createInBackground(file);
  });
}
