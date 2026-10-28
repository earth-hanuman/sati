import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// A habit the user is working. v1 keeps exactly one with [isFocus] = true,
/// but the schema already supports many (the "unlock many" decision).
class Loops extends Table {
  TextColumn get id => text()();
  TextColumn get behavior => text()();
  TextColumn get trigger => text().withDefault(const Constant(''))();
  TextColumn get rewardGuess => text().withDefault(const Constant(''))();
  BoolColumn get isFocus => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  TextColumn get colorKey => text().withDefault(const Constant('warm'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// One logged event against a loop. [type] is 'surf' or 'did'.
/// 'did' moments carry a [rewardValue] that feeds the reward-value trend;
/// 'surf' moments carry [urgeAfter] and are excluded from that trend.
class Moments extends Table {
  TextColumn get id => text()();
  TextColumn get loopId =>
      text().references(Loops, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  IntColumn get urgeStrength => integer()();
  IntColumn get urgeAfter => integer().nullable()();
  TextColumn get rewardCategory => text().nullable()();
  IntColumn get followupAnswerIndex => integer().nullable()();
  IntColumn get rewardValue => integer().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Loops, Moments])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  /// For tests: pass an in-memory executor.
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  // --- Loops ---

  Stream<Loop?> watchFocusLoop() {
    final q = select(loops)
      ..where((l) => l.isFocus.equals(true) & l.archivedAt.isNull())
      ..limit(1);
    return q.watchSingleOrNull();
  }

  Future<Loop?> focusLoop() {
    final q = select(loops)
      ..where((l) => l.isFocus.equals(true) & l.archivedAt.isNull())
      ..limit(1);
    return q.getSingleOrNull();
  }

  /// All active (non-archived) loops, oldest first.
  Stream<List<Loop>> watchActiveLoops() {
    final q = select(loops)
      ..where((l) => l.archivedAt.isNull())
      ..orderBy([(l) => OrderingTerm.asc(l.createdAt)]);
    return q.watch();
  }

  Future<void> insertLoop(LoopsCompanion loop) =>
      into(loops).insert(loop);

  /// Rename a loop's behavior.
  Future<void> renameLoop(String loopId, String behavior) =>
      (update(loops)..where((l) => l.id.equals(loopId)))
          .write(LoopsCompanion(behavior: Value(behavior)));

  /// Permanently delete a loop and all of its moments.
  Future<void> deleteLoop(String loopId) => transaction(() async {
        await (delete(moments)..where((m) => m.loopId.equals(loopId))).go();
        await (delete(loops)..where((l) => l.id.equals(loopId))).go();
      });

  // --- Moments ---

  Future<void> insertMoment(MomentsCompanion moment) =>
      into(moments).insert(moment);

  /// All moments for a loop, newest first.
  Stream<List<Moment>> watchMoments(String loopId) {
    final q = select(moments)
      ..where((m) => m.loopId.equals(loopId))
      ..orderBy([(m) => OrderingTerm.desc(m.createdAt)]);
    return q.watch();
  }

  /// Ordered reward values (oldest -> newest) from 'did' moments only.
  /// This is the raw series behind the reward-value trend.
  Future<List<int>> rewardSeries(String loopId) async {
    final q = select(moments)
      ..where((m) =>
          m.loopId.equals(loopId) &
          m.type.equals('did') &
          m.rewardValue.isNotNull())
      ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]);
    final rows = await q.get();
    return rows.map((m) => m.rewardValue!).toList();
  }

  /// Count of 'surf' moments (the "rode it out" counter).
  Future<int> surfCount(String loopId) async {
    final count = countAll();
    final q = selectOnly(moments)
      ..addColumns([count])
      ..where(moments.loopId.equals(loopId) & moments.type.equals('surf'));
    final row = await q.getSingle();
    return row.read(count) ?? 0;
  }
}

QueryExecutor _open() => driftDatabase(name: 'sati');
