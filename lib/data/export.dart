import 'dart:convert';
import 'dart:io';
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
