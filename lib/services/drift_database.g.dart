// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// ignore_for_file: type=lint
class $SeriesTable extends Series with TableInfo<$SeriesTable, Serie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, link];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'series';
  @override
  VerificationContext validateIntegrity(Insertable<Serie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Serie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Serie(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link'])!,
    );
  }

  @override
  $SeriesTable createAlias(String alias) {
    return $SeriesTable(attachedDatabase, alias);
  }
}

class Serie extends DataClass implements Insertable<Serie> {
  final int id;
  final String title;
  final String link;
  const Serie({required this.id, required this.title, required this.link});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['link'] = Variable<String>(link);
    return map;
  }

  SeriesCompanion toCompanion(bool nullToAbsent) {
    return SeriesCompanion(
      id: Value(id),
      title: Value(title),
      link: Value(link),
    );
  }

  factory Serie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Serie(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      link: serializer.fromJson<String>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'link': serializer.toJson<String>(link),
    };
  }

  Serie copyWith({int? id, String? title, String? link}) => Serie(
        id: id ?? this.id,
        title: title ?? this.title,
        link: link ?? this.link,
      );
  @override
  String toString() {
    return (StringBuffer('Serie(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Serie &&
          other.id == this.id &&
          other.title == this.title &&
          other.link == this.link);
}

class SeriesCompanion extends UpdateCompanion<Serie> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> link;
  const SeriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.link = const Value.absent(),
  });
  SeriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String link,
  })  : title = Value(title),
        link = Value(link);
  static Insertable<Serie> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (link != null) 'link': link,
    });
  }

  SeriesCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<String>? link}) {
    return SeriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

class $PopularsTable extends Populars with TableInfo<$PopularsTable, Popular> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PopularsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imgLinkMeta =
      const VerificationMeta('imgLink');
  @override
  late final GeneratedColumn<String> imgLink = GeneratedColumn<String>(
      'img_link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backdropUrlMeta =
      const VerificationMeta('backdropUrl');
  @override
  late final GeneratedColumn<String> backdropUrl = GeneratedColumn<String>(
      'backdrop_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, link, imgLink, backdropUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'populars';
  @override
  VerificationContext validateIntegrity(Insertable<Popular> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('img_link')) {
      context.handle(_imgLinkMeta,
          imgLink.isAcceptableOrUnknown(data['img_link']!, _imgLinkMeta));
    } else if (isInserting) {
      context.missing(_imgLinkMeta);
    }
    if (data.containsKey('backdrop_url')) {
      context.handle(
          _backdropUrlMeta,
          backdropUrl.isAcceptableOrUnknown(
              data['backdrop_url']!, _backdropUrlMeta));
    } else if (isInserting) {
      context.missing(_backdropUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Popular map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Popular(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link'])!,
      imgLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}img_link'])!,
      backdropUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_url'])!,
    );
  }

  @override
  $PopularsTable createAlias(String alias) {
    return $PopularsTable(attachedDatabase, alias);
  }
}

class Popular extends DataClass implements Insertable<Popular> {
  final int id;
  final String title;
  final String link;
  final String imgLink;
  final String backdropUrl;
  const Popular(
      {required this.id,
      required this.title,
      required this.link,
      required this.imgLink,
      required this.backdropUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['link'] = Variable<String>(link);
    map['img_link'] = Variable<String>(imgLink);
    map['backdrop_url'] = Variable<String>(backdropUrl);
    return map;
  }

  PopularsCompanion toCompanion(bool nullToAbsent) {
    return PopularsCompanion(
      id: Value(id),
      title: Value(title),
      link: Value(link),
      imgLink: Value(imgLink),
      backdropUrl: Value(backdropUrl),
    );
  }

  factory Popular.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Popular(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      link: serializer.fromJson<String>(json['link']),
      imgLink: serializer.fromJson<String>(json['imgLink']),
      backdropUrl: serializer.fromJson<String>(json['backdropUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'link': serializer.toJson<String>(link),
      'imgLink': serializer.toJson<String>(imgLink),
      'backdropUrl': serializer.toJson<String>(backdropUrl),
    };
  }

  Popular copyWith(
          {int? id,
          String? title,
          String? link,
          String? imgLink,
          String? backdropUrl}) =>
      Popular(
        id: id ?? this.id,
        title: title ?? this.title,
        link: link ?? this.link,
        imgLink: imgLink ?? this.imgLink,
        backdropUrl: backdropUrl ?? this.backdropUrl,
      );
  @override
  String toString() {
    return (StringBuffer('Popular(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('imgLink: $imgLink, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, link, imgLink, backdropUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Popular &&
          other.id == this.id &&
          other.title == this.title &&
          other.link == this.link &&
          other.imgLink == this.imgLink &&
          other.backdropUrl == this.backdropUrl);
}

class PopularsCompanion extends UpdateCompanion<Popular> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> link;
  final Value<String> imgLink;
  final Value<String> backdropUrl;
  const PopularsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.link = const Value.absent(),
    this.imgLink = const Value.absent(),
    this.backdropUrl = const Value.absent(),
  });
  PopularsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String link,
    required String imgLink,
    required String backdropUrl,
  })  : title = Value(title),
        link = Value(link),
        imgLink = Value(imgLink),
        backdropUrl = Value(backdropUrl);
  static Insertable<Popular> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? link,
    Expression<String>? imgLink,
    Expression<String>? backdropUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (link != null) 'link': link,
      if (imgLink != null) 'img_link': imgLink,
      if (backdropUrl != null) 'backdrop_url': backdropUrl,
    });
  }

  PopularsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? link,
      Value<String>? imgLink,
      Value<String>? backdropUrl}) {
    return PopularsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      imgLink: imgLink ?? this.imgLink,
      backdropUrl: backdropUrl ?? this.backdropUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (imgLink.present) {
      map['img_link'] = Variable<String>(imgLink.value);
    }
    if (backdropUrl.present) {
      map['backdrop_url'] = Variable<String>(backdropUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PopularsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('imgLink: $imgLink, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }
}

class $TrendingDaysTable extends TrendingDays
    with TableInfo<$TrendingDaysTable, TrendingDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrendingDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imgLinkMeta =
      const VerificationMeta('imgLink');
  @override
  late final GeneratedColumn<String> imgLink = GeneratedColumn<String>(
      'img_link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backdropUrlMeta =
      const VerificationMeta('backdropUrl');
  @override
  late final GeneratedColumn<String> backdropUrl = GeneratedColumn<String>(
      'backdrop_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, link, imgLink, backdropUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trending_days';
  @override
  VerificationContext validateIntegrity(Insertable<TrendingDay> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('img_link')) {
      context.handle(_imgLinkMeta,
          imgLink.isAcceptableOrUnknown(data['img_link']!, _imgLinkMeta));
    } else if (isInserting) {
      context.missing(_imgLinkMeta);
    }
    if (data.containsKey('backdrop_url')) {
      context.handle(
          _backdropUrlMeta,
          backdropUrl.isAcceptableOrUnknown(
              data['backdrop_url']!, _backdropUrlMeta));
    } else if (isInserting) {
      context.missing(_backdropUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrendingDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrendingDay(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link'])!,
      imgLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}img_link'])!,
      backdropUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_url'])!,
    );
  }

  @override
  $TrendingDaysTable createAlias(String alias) {
    return $TrendingDaysTable(attachedDatabase, alias);
  }
}

class TrendingDay extends DataClass implements Insertable<TrendingDay> {
  final int id;
  final String title;
  final String link;
  final String imgLink;
  final String backdropUrl;
  const TrendingDay(
      {required this.id,
      required this.title,
      required this.link,
      required this.imgLink,
      required this.backdropUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['link'] = Variable<String>(link);
    map['img_link'] = Variable<String>(imgLink);
    map['backdrop_url'] = Variable<String>(backdropUrl);
    return map;
  }

  TrendingDaysCompanion toCompanion(bool nullToAbsent) {
    return TrendingDaysCompanion(
      id: Value(id),
      title: Value(title),
      link: Value(link),
      imgLink: Value(imgLink),
      backdropUrl: Value(backdropUrl),
    );
  }

  factory TrendingDay.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrendingDay(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      link: serializer.fromJson<String>(json['link']),
      imgLink: serializer.fromJson<String>(json['imgLink']),
      backdropUrl: serializer.fromJson<String>(json['backdropUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'link': serializer.toJson<String>(link),
      'imgLink': serializer.toJson<String>(imgLink),
      'backdropUrl': serializer.toJson<String>(backdropUrl),
    };
  }

  TrendingDay copyWith(
          {int? id,
          String? title,
          String? link,
          String? imgLink,
          String? backdropUrl}) =>
      TrendingDay(
        id: id ?? this.id,
        title: title ?? this.title,
        link: link ?? this.link,
        imgLink: imgLink ?? this.imgLink,
        backdropUrl: backdropUrl ?? this.backdropUrl,
      );
  @override
  String toString() {
    return (StringBuffer('TrendingDay(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('imgLink: $imgLink, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, link, imgLink, backdropUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrendingDay &&
          other.id == this.id &&
          other.title == this.title &&
          other.link == this.link &&
          other.imgLink == this.imgLink &&
          other.backdropUrl == this.backdropUrl);
}

class TrendingDaysCompanion extends UpdateCompanion<TrendingDay> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> link;
  final Value<String> imgLink;
  final Value<String> backdropUrl;
  const TrendingDaysCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.link = const Value.absent(),
    this.imgLink = const Value.absent(),
    this.backdropUrl = const Value.absent(),
  });
  TrendingDaysCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String link,
    required String imgLink,
    required String backdropUrl,
  })  : title = Value(title),
        link = Value(link),
        imgLink = Value(imgLink),
        backdropUrl = Value(backdropUrl);
  static Insertable<TrendingDay> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? link,
    Expression<String>? imgLink,
    Expression<String>? backdropUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (link != null) 'link': link,
      if (imgLink != null) 'img_link': imgLink,
      if (backdropUrl != null) 'backdrop_url': backdropUrl,
    });
  }

  TrendingDaysCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? link,
      Value<String>? imgLink,
      Value<String>? backdropUrl}) {
    return TrendingDaysCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      imgLink: imgLink ?? this.imgLink,
      backdropUrl: backdropUrl ?? this.backdropUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (imgLink.present) {
      map['img_link'] = Variable<String>(imgLink.value);
    }
    if (backdropUrl.present) {
      map['backdrop_url'] = Variable<String>(backdropUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrendingDaysCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('imgLink: $imgLink, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }
}

class $TrendingWeeksTable extends TrendingWeeks
    with TableInfo<$TrendingWeeksTable, TrendingWeek> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrendingWeeksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imgLinkMeta =
      const VerificationMeta('imgLink');
  @override
  late final GeneratedColumn<String> imgLink = GeneratedColumn<String>(
      'img_link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backdropUrlMeta =
      const VerificationMeta('backdropUrl');
  @override
  late final GeneratedColumn<String> backdropUrl = GeneratedColumn<String>(
      'backdrop_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, link, imgLink, backdropUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trending_weeks';
  @override
  VerificationContext validateIntegrity(Insertable<TrendingWeek> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('img_link')) {
      context.handle(_imgLinkMeta,
          imgLink.isAcceptableOrUnknown(data['img_link']!, _imgLinkMeta));
    } else if (isInserting) {
      context.missing(_imgLinkMeta);
    }
    if (data.containsKey('backdrop_url')) {
      context.handle(
          _backdropUrlMeta,
          backdropUrl.isAcceptableOrUnknown(
              data['backdrop_url']!, _backdropUrlMeta));
    } else if (isInserting) {
      context.missing(_backdropUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrendingWeek map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrendingWeek(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link'])!,
      imgLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}img_link'])!,
      backdropUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_url'])!,
    );
  }

  @override
  $TrendingWeeksTable createAlias(String alias) {
    return $TrendingWeeksTable(attachedDatabase, alias);
  }
}

class TrendingWeek extends DataClass implements Insertable<TrendingWeek> {
  final int id;
  final String title;
  final String link;
  final String imgLink;
  final String backdropUrl;
  const TrendingWeek(
      {required this.id,
      required this.title,
      required this.link,
      required this.imgLink,
      required this.backdropUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['link'] = Variable<String>(link);
    map['img_link'] = Variable<String>(imgLink);
    map['backdrop_url'] = Variable<String>(backdropUrl);
    return map;
  }

  TrendingWeeksCompanion toCompanion(bool nullToAbsent) {
    return TrendingWeeksCompanion(
      id: Value(id),
      title: Value(title),
      link: Value(link),
      imgLink: Value(imgLink),
      backdropUrl: Value(backdropUrl),
    );
  }

  factory TrendingWeek.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrendingWeek(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      link: serializer.fromJson<String>(json['link']),
      imgLink: serializer.fromJson<String>(json['imgLink']),
      backdropUrl: serializer.fromJson<String>(json['backdropUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'link': serializer.toJson<String>(link),
      'imgLink': serializer.toJson<String>(imgLink),
      'backdropUrl': serializer.toJson<String>(backdropUrl),
    };
  }

  TrendingWeek copyWith(
          {int? id,
          String? title,
          String? link,
          String? imgLink,
          String? backdropUrl}) =>
      TrendingWeek(
        id: id ?? this.id,
        title: title ?? this.title,
        link: link ?? this.link,
        imgLink: imgLink ?? this.imgLink,
        backdropUrl: backdropUrl ?? this.backdropUrl,
      );
  @override
  String toString() {
    return (StringBuffer('TrendingWeek(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('imgLink: $imgLink, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, link, imgLink, backdropUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrendingWeek &&
          other.id == this.id &&
          other.title == this.title &&
          other.link == this.link &&
          other.imgLink == this.imgLink &&
          other.backdropUrl == this.backdropUrl);
}

class TrendingWeeksCompanion extends UpdateCompanion<TrendingWeek> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> link;
  final Value<String> imgLink;
  final Value<String> backdropUrl;
  const TrendingWeeksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.link = const Value.absent(),
    this.imgLink = const Value.absent(),
    this.backdropUrl = const Value.absent(),
  });
  TrendingWeeksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String link,
    required String imgLink,
    required String backdropUrl,
  })  : title = Value(title),
        link = Value(link),
        imgLink = Value(imgLink),
        backdropUrl = Value(backdropUrl);
  static Insertable<TrendingWeek> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? link,
    Expression<String>? imgLink,
    Expression<String>? backdropUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (link != null) 'link': link,
      if (imgLink != null) 'img_link': imgLink,
      if (backdropUrl != null) 'backdrop_url': backdropUrl,
    });
  }

  TrendingWeeksCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? link,
      Value<String>? imgLink,
      Value<String>? backdropUrl}) {
    return TrendingWeeksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
      imgLink: imgLink ?? this.imgLink,
      backdropUrl: backdropUrl ?? this.backdropUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (imgLink.present) {
      map['img_link'] = Variable<String>(imgLink.value);
    }
    if (backdropUrl.present) {
      map['backdrop_url'] = Variable<String>(backdropUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrendingWeeksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('link: $link, ')
          ..write('imgLink: $imgLink, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }
}

class $LastSyncedTable extends LastSynced
    with TableInfo<$LastSyncedTable, LastSyncedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LastSyncedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, kind, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'last_synced';
  @override
  VerificationContext validateIntegrity(Insertable<LastSyncedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LastSyncedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LastSyncedData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
    );
  }

  @override
  $LastSyncedTable createAlias(String alias) {
    return $LastSyncedTable(attachedDatabase, alias);
  }
}

class LastSyncedData extends DataClass implements Insertable<LastSyncedData> {
  final int id;
  final String kind;
  final DateTime time;
  const LastSyncedData(
      {required this.id, required this.kind, required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kind'] = Variable<String>(kind);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  LastSyncedCompanion toCompanion(bool nullToAbsent) {
    return LastSyncedCompanion(
      id: Value(id),
      kind: Value(kind),
      time: Value(time),
    );
  }

  factory LastSyncedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LastSyncedData(
      id: serializer.fromJson<int>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kind': serializer.toJson<String>(kind),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  LastSyncedData copyWith({int? id, String? kind, DateTime? time}) =>
      LastSyncedData(
        id: id ?? this.id,
        kind: kind ?? this.kind,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('LastSyncedData(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kind, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LastSyncedData &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.time == this.time);
}

class LastSyncedCompanion extends UpdateCompanion<LastSyncedData> {
  final Value<int> id;
  final Value<String> kind;
  final Value<DateTime> time;
  const LastSyncedCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.time = const Value.absent(),
  });
  LastSyncedCompanion.insert({
    this.id = const Value.absent(),
    required String kind,
    required DateTime time,
  })  : kind = Value(kind),
        time = Value(time);
  static Insertable<LastSyncedData> custom({
    Expression<int>? id,
    Expression<String>? kind,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (time != null) 'time': time,
    });
  }

  LastSyncedCompanion copyWith(
      {Value<int>? id, Value<String>? kind, Value<DateTime>? time}) {
    return LastSyncedCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LastSyncedCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $HeadersTable extends Headers with TableInfo<$HeadersTable, Header> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HeadersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imgLinkMeta =
      const VerificationMeta('imgLink');
  @override
  late final GeneratedColumn<String> imgLink = GeneratedColumn<String>(
      'img_link', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _backdropUrlMeta =
      const VerificationMeta('backdropUrl');
  @override
  late final GeneratedColumn<String> backdropUrl = GeneratedColumn<String>(
      'backdrop_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, imgLink, description, url, backdropUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'headers';
  @override
  VerificationContext validateIntegrity(Insertable<Header> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('img_link')) {
      context.handle(_imgLinkMeta,
          imgLink.isAcceptableOrUnknown(data['img_link']!, _imgLinkMeta));
    } else if (isInserting) {
      context.missing(_imgLinkMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('backdrop_url')) {
      context.handle(
          _backdropUrlMeta,
          backdropUrl.isAcceptableOrUnknown(
              data['backdrop_url']!, _backdropUrlMeta));
    } else if (isInserting) {
      context.missing(_backdropUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Header map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Header(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      imgLink: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}img_link'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      backdropUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}backdrop_url'])!,
    );
  }

  @override
  $HeadersTable createAlias(String alias) {
    return $HeadersTable(attachedDatabase, alias);
  }
}

class Header extends DataClass implements Insertable<Header> {
  final int id;
  final String title;
  final String imgLink;
  final String description;
  final String url;
  final String backdropUrl;
  const Header(
      {required this.id,
      required this.title,
      required this.imgLink,
      required this.description,
      required this.url,
      required this.backdropUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['img_link'] = Variable<String>(imgLink);
    map['description'] = Variable<String>(description);
    map['url'] = Variable<String>(url);
    map['backdrop_url'] = Variable<String>(backdropUrl);
    return map;
  }

  HeadersCompanion toCompanion(bool nullToAbsent) {
    return HeadersCompanion(
      id: Value(id),
      title: Value(title),
      imgLink: Value(imgLink),
      description: Value(description),
      url: Value(url),
      backdropUrl: Value(backdropUrl),
    );
  }

  factory Header.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Header(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      imgLink: serializer.fromJson<String>(json['imgLink']),
      description: serializer.fromJson<String>(json['description']),
      url: serializer.fromJson<String>(json['url']),
      backdropUrl: serializer.fromJson<String>(json['backdropUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'imgLink': serializer.toJson<String>(imgLink),
      'description': serializer.toJson<String>(description),
      'url': serializer.toJson<String>(url),
      'backdropUrl': serializer.toJson<String>(backdropUrl),
    };
  }

  Header copyWith(
          {int? id,
          String? title,
          String? imgLink,
          String? description,
          String? url,
          String? backdropUrl}) =>
      Header(
        id: id ?? this.id,
        title: title ?? this.title,
        imgLink: imgLink ?? this.imgLink,
        description: description ?? this.description,
        url: url ?? this.url,
        backdropUrl: backdropUrl ?? this.backdropUrl,
      );
  @override
  String toString() {
    return (StringBuffer('Header(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imgLink: $imgLink, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, imgLink, description, url, backdropUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Header &&
          other.id == this.id &&
          other.title == this.title &&
          other.imgLink == this.imgLink &&
          other.description == this.description &&
          other.url == this.url &&
          other.backdropUrl == this.backdropUrl);
}

class HeadersCompanion extends UpdateCompanion<Header> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> imgLink;
  final Value<String> description;
  final Value<String> url;
  final Value<String> backdropUrl;
  const HeadersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.imgLink = const Value.absent(),
    this.description = const Value.absent(),
    this.url = const Value.absent(),
    this.backdropUrl = const Value.absent(),
  });
  HeadersCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String imgLink,
    required String description,
    required String url,
    required String backdropUrl,
  })  : title = Value(title),
        imgLink = Value(imgLink),
        description = Value(description),
        url = Value(url),
        backdropUrl = Value(backdropUrl);
  static Insertable<Header> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? imgLink,
    Expression<String>? description,
    Expression<String>? url,
    Expression<String>? backdropUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (imgLink != null) 'img_link': imgLink,
      if (description != null) 'description': description,
      if (url != null) 'url': url,
      if (backdropUrl != null) 'backdrop_url': backdropUrl,
    });
  }

  HeadersCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? imgLink,
      Value<String>? description,
      Value<String>? url,
      Value<String>? backdropUrl}) {
    return HeadersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      imgLink: imgLink ?? this.imgLink,
      description: description ?? this.description,
      url: url ?? this.url,
      backdropUrl: backdropUrl ?? this.backdropUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (imgLink.present) {
      map['img_link'] = Variable<String>(imgLink.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (backdropUrl.present) {
      map['backdrop_url'] = Variable<String>(backdropUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HeadersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imgLink: $imgLink, ')
          ..write('description: $description, ')
          ..write('url: $url, ')
          ..write('backdropUrl: $backdropUrl')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $SeriesTable series = $SeriesTable(this);
  late final $PopularsTable populars = $PopularsTable(this);
  late final $TrendingDaysTable trendingDays = $TrendingDaysTable(this);
  late final $TrendingWeeksTable trendingWeeks = $TrendingWeeksTable(this);
  late final $LastSyncedTable lastSynced = $LastSyncedTable(this);
  late final $HeadersTable headers = $HeadersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [series, populars, trendingDays, trendingWeeks, lastSynced, headers];
}
