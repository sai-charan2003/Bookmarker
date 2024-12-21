// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addedDateMeta =
      const VerificationMeta('addedDate');
  @override
  late final GeneratedColumn<String> addedDate = GeneratedColumn<String>(
      'added_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageURLMeta =
      const VerificationMeta('imageURL');
  @override
  late final GeneratedColumn<String> imageURL = GeneratedColumn<String>(
      'image_u_r_l', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hostURLMeta =
      const VerificationMeta('hostURL');
  @override
  late final GeneratedColumn<String> hostURL = GeneratedColumn<String>(
      'host_u_r_l', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
      'uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [link, title, addedDate, imageURL, hostURL, uuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('added_date')) {
      context.handle(_addedDateMeta,
          addedDate.isAcceptableOrUnknown(data['added_date']!, _addedDateMeta));
    }
    if (data.containsKey('image_u_r_l')) {
      context.handle(_imageURLMeta,
          imageURL.isAcceptableOrUnknown(data['image_u_r_l']!, _imageURLMeta));
    }
    if (data.containsKey('host_u_r_l')) {
      context.handle(_hostURLMeta,
          hostURL.isAcceptableOrUnknown(data['host_u_r_l']!, _hostURLMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      addedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}added_date']),
      imageURL: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_u_r_l']),
      hostURL: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}host_u_r_l']),
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uuid'])!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final String? link;
  final String? title;
  final String? addedDate;
  final String? imageURL;
  final String? hostURL;
  final String uuid;
  const Bookmark(
      {this.link,
      this.title,
      this.addedDate,
      this.imageURL,
      this.hostURL,
      required this.uuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || addedDate != null) {
      map['added_date'] = Variable<String>(addedDate);
    }
    if (!nullToAbsent || imageURL != null) {
      map['image_u_r_l'] = Variable<String>(imageURL);
    }
    if (!nullToAbsent || hostURL != null) {
      map['host_u_r_l'] = Variable<String>(hostURL);
    }
    map['uuid'] = Variable<String>(uuid);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      addedDate: addedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(addedDate),
      imageURL: imageURL == null && nullToAbsent
          ? const Value.absent()
          : Value(imageURL),
      hostURL: hostURL == null && nullToAbsent
          ? const Value.absent()
          : Value(hostURL),
      uuid: Value(uuid),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      link: serializer.fromJson<String?>(json['link']),
      title: serializer.fromJson<String?>(json['title']),
      addedDate: serializer.fromJson<String?>(json['addedDate']),
      imageURL: serializer.fromJson<String?>(json['imageURL']),
      hostURL: serializer.fromJson<String?>(json['hostURL']),
      uuid: serializer.fromJson<String>(json['uuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'link': serializer.toJson<String?>(link),
      'title': serializer.toJson<String?>(title),
      'addedDate': serializer.toJson<String?>(addedDate),
      'imageURL': serializer.toJson<String?>(imageURL),
      'hostURL': serializer.toJson<String?>(hostURL),
      'uuid': serializer.toJson<String>(uuid),
    };
  }

  Bookmark copyWith(
          {Value<String?> link = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<String?> addedDate = const Value.absent(),
          Value<String?> imageURL = const Value.absent(),
          Value<String?> hostURL = const Value.absent(),
          String? uuid}) =>
      Bookmark(
        link: link.present ? link.value : this.link,
        title: title.present ? title.value : this.title,
        addedDate: addedDate.present ? addedDate.value : this.addedDate,
        imageURL: imageURL.present ? imageURL.value : this.imageURL,
        hostURL: hostURL.present ? hostURL.value : this.hostURL,
        uuid: uuid ?? this.uuid,
      );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      link: data.link.present ? data.link.value : this.link,
      title: data.title.present ? data.title.value : this.title,
      addedDate: data.addedDate.present ? data.addedDate.value : this.addedDate,
      imageURL: data.imageURL.present ? data.imageURL.value : this.imageURL,
      hostURL: data.hostURL.present ? data.hostURL.value : this.hostURL,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('link: $link, ')
          ..write('title: $title, ')
          ..write('addedDate: $addedDate, ')
          ..write('imageURL: $imageURL, ')
          ..write('hostURL: $hostURL, ')
          ..write('uuid: $uuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(link, title, addedDate, imageURL, hostURL, uuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.link == this.link &&
          other.title == this.title &&
          other.addedDate == this.addedDate &&
          other.imageURL == this.imageURL &&
          other.hostURL == this.hostURL &&
          other.uuid == this.uuid);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<String?> link;
  final Value<String?> title;
  final Value<String?> addedDate;
  final Value<String?> imageURL;
  final Value<String?> hostURL;
  final Value<String> uuid;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.link = const Value.absent(),
    this.title = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.imageURL = const Value.absent(),
    this.hostURL = const Value.absent(),
    this.uuid = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.link = const Value.absent(),
    this.title = const Value.absent(),
    this.addedDate = const Value.absent(),
    this.imageURL = const Value.absent(),
    this.hostURL = const Value.absent(),
    required String uuid,
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid);
  static Insertable<Bookmark> custom({
    Expression<String>? link,
    Expression<String>? title,
    Expression<String>? addedDate,
    Expression<String>? imageURL,
    Expression<String>? hostURL,
    Expression<String>? uuid,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (link != null) 'link': link,
      if (title != null) 'title': title,
      if (addedDate != null) 'added_date': addedDate,
      if (imageURL != null) 'image_u_r_l': imageURL,
      if (hostURL != null) 'host_u_r_l': hostURL,
      if (uuid != null) 'uuid': uuid,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith(
      {Value<String?>? link,
      Value<String?>? title,
      Value<String?>? addedDate,
      Value<String?>? imageURL,
      Value<String?>? hostURL,
      Value<String>? uuid,
      Value<int>? rowid}) {
    return BookmarksCompanion(
      link: link ?? this.link,
      title: title ?? this.title,
      addedDate: addedDate ?? this.addedDate,
      imageURL: imageURL ?? this.imageURL,
      hostURL: hostURL ?? this.hostURL,
      uuid: uuid ?? this.uuid,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (addedDate.present) {
      map['added_date'] = Variable<String>(addedDate.value);
    }
    if (imageURL.present) {
      map['image_u_r_l'] = Variable<String>(imageURL.value);
    }
    if (hostURL.present) {
      map['host_u_r_l'] = Variable<String>(hostURL.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('link: $link, ')
          ..write('title: $title, ')
          ..write('addedDate: $addedDate, ')
          ..write('imageURL: $imageURL, ')
          ..write('hostURL: $hostURL, ')
          ..write('uuid: $uuid, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bookmarks];
}

typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  Value<String?> link,
  Value<String?> title,
  Value<String?> addedDate,
  Value<String?> imageURL,
  Value<String?> hostURL,
  required String uuid,
  Value<int> rowid,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<String?> link,
  Value<String?> title,
  Value<String?> addedDate,
  Value<String?> imageURL,
  Value<String?> hostURL,
  Value<String> uuid,
  Value<int> rowid,
});

class $$BookmarksTableFilterComposer
    extends FilterComposer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer(super.$state);
  ColumnFilters<String> get link => $state.composableBuilder(
      column: $state.table.link,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get addedDate => $state.composableBuilder(
      column: $state.table.addedDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get imageURL => $state.composableBuilder(
      column: $state.table.imageURL,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get hostURL => $state.composableBuilder(
      column: $state.table.hostURL,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$BookmarksTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer(super.$state);
  ColumnOrderings<String> get link => $state.composableBuilder(
      column: $state.table.link,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get addedDate => $state.composableBuilder(
      column: $state.table.addedDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get imageURL => $state.composableBuilder(
      column: $state.table.imageURL,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get hostURL => $state.composableBuilder(
      column: $state.table.hostURL,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get uuid => $state.composableBuilder(
      column: $state.table.uuid,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$BookmarksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()> {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$BookmarksTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$BookmarksTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String?> link = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> addedDate = const Value.absent(),
            Value<String?> imageURL = const Value.absent(),
            Value<String?> hostURL = const Value.absent(),
            Value<String> uuid = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksCompanion(
            link: link,
            title: title,
            addedDate: addedDate,
            imageURL: imageURL,
            hostURL: hostURL,
            uuid: uuid,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> link = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> addedDate = const Value.absent(),
            Value<String?> imageURL = const Value.absent(),
            Value<String?> hostURL = const Value.absent(),
            required String uuid,
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksCompanion.insert(
            link: link,
            title: title,
            addedDate: addedDate,
            imageURL: imageURL,
            hostURL: hostURL,
            uuid: uuid,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BookmarksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
}
