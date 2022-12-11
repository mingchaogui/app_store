import 'package:app_store/model/applications/entry.dart';
import 'package:app_store/model/look_up/look_up_result.dart';
import 'package:collection/collection.dart';
import 'package:sqflite/sqflite.dart';

final SqliteTool kSqliteTool = SqliteTool();

const String _path = 'app_store.db';
const int _version = 1;

class SqliteTool {
  late final AppsTable appsTable;
  late final TopFreeAppsTable topFreeAppsTable;
  // Unused
  // late final LookUpResultsTable lookUpResultsTable;

  Future<Database> openDb() async {
    return openDatabase(
      _path,
      version: _version,
      onCreate: _onCreate,
    ).then((Database db) {
      appsTable = AppsTable(db);
      topFreeAppsTable = TopFreeAppsTable(db);
      // lookUpResultsTable = LookUpResultsTable(db);
      return db;
    });
  }

  Future<void> _onCreate(Database db, int version) async {
    await AppsTable.create(db, version);
    await TopFreeAppsTable.create(db, version);
    // await LookUpResultsTable.create(db, version);
  }
}

// App总表
class AppsTable extends _BaseTable {
  AppsTable(super.db);

  static const String table = 'apps';
  static const String fTrackId = 'trackId';
  static const String fName = 'name';
  static const String fSummary = 'summary';
  static const String fArtist = 'artist';
  static const String fExtras = 'extras';

  static Future<void> create(Database db, int version) {
    return db.execute(
        'CREATE TABLE $table ($fTrackId INTEGER PRIMARY KEY, $fName TEXT, $fSummary TEXT, $fArtist TEXT, $fExtras TEXT)');
  }

  Future<List<EntryModel>> queryLikeName({
    required String name,
    int? limit,
  }) {
    return db
        .query(
      table,
      where: '$fName LIKE ? OR $fSummary LIKE ? OR $fArtist LIKE ?',
      whereArgs: <dynamic>[
        '%$name%',
        '%$name%',
        '%$name%',
      ],
      limit: limit,
    )
        .then((List<Map<String, Object?>> value) {
      return List<EntryModel>.generate(value.length, (int index) {
        final Map<String, Object?> data = value[index];
        return EntryModel.fromDbJson(data);
      });
    });
  }

  Future<int> saveAll(Iterable<EntryModel> models) {
    final Batch batch = db.batch();
    for (final EntryModel model in models) {
      batch.insert(
        table,
        model.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return batch
        .commit(continueOnError: true)
        .then((List<Object?> value) => value.asTotal);
  }
}

// 下载量最多的免费App，只存Id
class TopFreeAppsTable extends _BaseTable {
  TopFreeAppsTable(super.db);

  static const String table = 'topFreeApps';
  static const String fId = 'id';
  static const String fTrackId = 'trackId';

  static Future<void> create(Database db, int version) {
    return db.execute(
        'CREATE TABLE $table ($fId INTEGER PRIMARY KEY, $fTrackId INTEGER UNIQUE NOT NULL)');
  }

  // 连接App总表，结果以当前表的Id排序
  Future<List<EntryModel>> queryAll({
    required int limit,
    int? offset,
  }) {
    return db
        .rawQuery(
            'SELECT * FROM ${AppsTable.table} JOIN $table USING ($fTrackId) WHERE $fTrackId IN (SELECT $fTrackId FROM $table LIMIT $limit OFFSET $offset) ORDER BY $fId')
        .then((List<Map<String, Object?>> value) {
      return List<EntryModel>.generate(value.length, (int index) {
        final Map<String, Object?> data = value[index];
        return EntryModel.fromDbJson(data);
      });
    });
  }

  Future<int> saveAll(Iterable<int> ids) {
    final Batch batch = db.batch()..delete(table);
    for (final int id in ids) {
      batch.insert(
        table,
        <String, dynamic>{
          fTrackId: id,
        },
      );
    }
    return batch.commit().then((List<Object?> value) => value.asTotal);
  }
}

// App评分
class LookUpResultsTable extends _BaseTable {
  LookUpResultsTable(super.db);

  static const String table = 'lookUpResults';
  static const String fTrackId = 'trackId';
  static const String fAverageUserRating = 'averageUserRating';
  static const String fUserRatingCount = 'userRatingCount';

  static Future<void> create(Database db, int version) {
    return db.execute(
        'CREATE TABLE $table ($fTrackId INTEGER PRIMARY KEY, $fAverageUserRating REAL, $fUserRatingCount INTEGER)');
  }

  Future<LookUpResultModel?> queryByTrackId({
    required int trackId,
    int limit = 1,
  }) {
    return db
        .query(table, limit: limit)
        .then((List<Map<String, Object?>> value) {
      final Map<String, Object?>? data = value.firstOrNull;
      if (data == null) {
        return null;
      }
      return LookUpResultModel.fromDbJson(data);
    });
  }

  Future<int> saveAll(List<LookUpResultModel> models) {
    final Batch batch = db.batch();
    for (final LookUpResultModel model in models) {
      batch.insert(
        table,
        model.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    return batch
        .commit(continueOnError: true)
        .then((List<Object?> value) => value.asTotal);
  }
}

abstract class _BaseTable {
  _BaseTable(this.db);

  final Database db;
}

extension _BatchResultListExtension on List<Object?> {
  int get asTotal {
    int total = 0;
    for (final Object? count in this) {
      if (count is int) {
        total += count;
      }
    }
    return total;
  }
}
