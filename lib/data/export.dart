import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart' show Value;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'database.dart';

/// Serializes all loops + moments to the JSON shape documented in DATA_MODEL.md.
Map<String, dynamic> buildExportJson(List<Loop> loops, List<Moment> moments) {
  return {
    'schemaVersion': 1,
    'exportedAt': DateTime.now().toUtc().toIso8601String(),
    'loops': [
      for (final l in loops)
        {
          'id': l.id,
          'behavior': l.behavior,
          'trigger': l.trigger,
          'rewardGuess': l.rewardGuess,
          'isFocus': l.isFocus,
          'createdAt': l.createdAt.toUtc().toIso8601String(),
          'archivedAt': l.archivedAt?.toUtc().toIso8601String(),
          'colorKey': l.colorKey,
        },
    ],
    'moments': [
      for (final m in moments)
        {
          'id': m.id,
          'loopId': m.loopId,
          'type': m.type,
          'urgeStrength': m.urgeStrength,
          'urgeAfter': m.urgeAfter,
          'rewardCategory': m.rewardCategory,
          'followupAnswerIndex': m.followupAnswerIndex,
          'rewardValue': m.rewardValue,
          'note': m.note,
          'createdAt': m.createdAt.toUtc().toIso8601String(),
        },
    ],
  };
}

/// Builds the backup file and opens the OS share sheet.
Future<void> exportBackup(AppDatabase db) async {
  final loops = await db.allLoops();
  final moments = await db.allMoments();
  final json = const JsonEncoder.withIndent('  ').convert(buildExportJson(loops, moments));

  final stamp = DateTime.now().toIso8601String().split('T').first;
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/sati-backup-$stamp.json');
  await file.writeAsString(json);

  await Share.shareXFiles(
    [XFile(file.path, mimeType: 'application/json')],
    subject: 'Sati backup',
    text: 'Your Sati habit data (${loops.length} habits, ${moments.length} moments).',
  );
}

class ImportResult {
  final int loops;
  final int moments;
  const ImportResult(this.loops, this.moments);
}

DateTime _parseDate(Object? v) => DateTime.parse(v as String).toUtc();

/// Parses a backup JSON string and upserts it into the database.
/// Throws [FormatException] if the file isn't a recognizable Sati backup.
Future<ImportResult> importBackupString(AppDatabase db, String jsonStr) async {
  final Object? decoded = jsonDecode(jsonStr);
  if (decoded is! Map<String, dynamic>) {
    throw const FormatException('Not a Sati backup file.');
  }
  if (decoded['schemaVersion'] != 1) {
    throw const FormatException('Unsupported backup version.');
  }
  final loopsJson = (decoded['loops'] as List?) ?? const [];
  final momentsJson = (decoded['moments'] as List?) ?? const [];

  final loopRows = <LoopsCompanion>[
    for (final l in loopsJson.cast<Map<String, dynamic>>())
      LoopsCompanion(
        id: Value(l['id'] as String),
        behavior: Value(l['behavior'] as String),
        trigger: Value((l['trigger'] as String?) ?? ''),
        rewardGuess: Value((l['rewardGuess'] as String?) ?? ''),
        isFocus: Value((l['isFocus'] as bool?) ?? false),
        createdAt: Value(_parseDate(l['createdAt'])),
        archivedAt: Value(l['archivedAt'] == null ? null : _parseDate(l['archivedAt'])),
        colorKey: Value((l['colorKey'] as String?) ?? 'warm'),
      ),
  ];
  final momentRows = <MomentsCompanion>[
    for (final m in momentsJson.cast<Map<String, dynamic>>())
      MomentsCompanion(
        id: Value(m['id'] as String),
        loopId: Value(m['loopId'] as String),
        type: Value(m['type'] as String),
        urgeStrength: Value(m['urgeStrength'] as int),
        urgeAfter: Value(m['urgeAfter'] as int?),
        rewardCategory: Value(m['rewardCategory'] as String?),
        followupAnswerIndex: Value(m['followupAnswerIndex'] as int?),
        rewardValue: Value(m['rewardValue'] as int?),
        note: Value(m['note'] as String?),
        createdAt: Value(_parseDate(m['createdAt'])),
      ),
  ];

  await db.importAll(loopRows, momentRows);
  return ImportResult(loopRows.length, momentRows.length);
}
