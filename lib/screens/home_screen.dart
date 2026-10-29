import 'package:flutter/material.dart';
import '../data/database.dart';
import '../data/db_provider.dart';
import '../data/export.dart';
import '../data/trend.dart';
import '../theme/app_theme.dart';
import '../widgets/trend_chart.dart';
import '../widgets/ui.dart';
import 'add_loop_screen.dart';
import 'import_action.dart';
import 'moment_capture_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Loop> loops;
  const HomeScreen({super.key, required this.loops});

  @override
  Widget build(BuildContext context) {
    final db = DatabaseProvider.of(context);
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Pay attention to your habits, no judgment',
                  style: TextStyle(
                    color: context.c.muted,
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                tooltip: 'Backup',
                icon: Icon(Icons.more_horiz, color: context.c.muted, size: 24),
                color: context.c.surface,
                onSelected: (v) async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (v == 'export') {
                    try {
                      await exportBackup(db);
                    } catch (_) {
                      messenger.showSnackBar(
                        const SnackBar(content: Text("Couldn't export right now.")),
                      );
                    }
                  } else if (v == 'import') {
                    await importBackupFlow(context, db);
                  }
                },
                itemBuilder: (ctx) => [
                  PopupMenuItem(
                    value: 'export',
                    child: Text('Export backup', style: TextStyle(color: context.c.text)),
                  ),
                  PopupMenuItem(
                    value: 'import',
                    child: Text('Import backup', style: TextStyle(color: context.c.text)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 8),
              itemCount: loops.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 14),
              itemBuilder: (context, i) {
                if (i == loops.length) {
                  return _AddHabitCard(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AddLoopScreen()),
                    ),
                  );
                }
                return _LoopCardTile(loop: loops[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A tappable loop card. Tapping it starts a Moment for that loop.
class _LoopCardTile extends StatelessWidget {
  final Loop loop;
  const _LoopCardTile({required this.loop});

  List<int> _series(List<Moment> moments) {
    final did = moments.where((m) => m.type == 'did' && m.rewardValue != null).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return did.map((m) => m.rewardValue!).toList();
  }

  Future<void> _showActions(BuildContext context, AppDatabase db) async {
    final c = context.c;
    final action = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: c.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: c.line, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(loop.behavior,
                    style: TextStyle(color: c.text, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit_outlined, color: c.text),
              title: Text('Rename', style: TextStyle(color: c.text)),
              onTap: () => Navigator.of(ctx).pop('rename'),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Color(0xFFE06C6C)),
              title: const Text('Delete', style: TextStyle(color: Color(0xFFE06C6C))),
              onTap: () => Navigator.of(ctx).pop('delete'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (!context.mounted) return;
    if (action == 'rename') {
      await _rename(context, db);
    } else if (action == 'delete') {
      await _confirmDelete(context, db);
    }
  }

  Future<void> _rename(BuildContext context, AppDatabase db) async {
    final c = context.c;
    final ctrl = TextEditingController(text: loop.behavior);
    final newName = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: c.surface,
        title: Text('Rename habit', style: TextStyle(color: c.text)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          style: TextStyle(color: c.text),
          decoration: InputDecoration(
            hintText: 'habit name',
            hintStyle: TextStyle(color: c.faint),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: c.line)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: c.accent)),
          ),
          onSubmitted: (v) => Navigator.of(ctx).pop(v.trim()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cancel', style: TextStyle(color: c.muted)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(ctrl.text.trim()),
            child: Text('Save', style: TextStyle(color: c.accent)),
          ),
        ],
      ),
    );
    if (newName != null && newName.isNotEmpty && newName != loop.behavior) {
      await db.renameLoop(loop.id, newName);
    }
  }

  Future<void> _confirmDelete(BuildContext context, AppDatabase db) async {
    final c = context.c;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: c.surface,
        title: Text('Delete this habit?', style: TextStyle(color: c.text)),
        content: Text(
          '"${loop.behavior}" and all its logged moments will be removed. This can\'t be undone.',
          style: TextStyle(color: c.muted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Cancel', style: TextStyle(color: c.muted)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Color(0xFFE06C6C))),
          ),
        ],
      ),
    );
    if (ok == true) await db.deleteLoop(loop.id);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.c;
    final db = DatabaseProvider.of(context);
    return Material(
      color: c.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => MomentCaptureScreen(loop: loop)),
        ),
        onLongPress: () => _showActions(context, db),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: c.line),
          ),
          padding: const EdgeInsets.all(18),
          child: StreamBuilder<List<Moment>>(
            stream: db.watchMoments(loop.id),
            builder: (context, snap) {
              final moments = snap.data ?? const <Moment>[];
              final raw = _series(moments);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(color: c.warm, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(loop.behavior,
                            style: TextStyle(color: c.text, fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      Icon(Icons.chevron_right, color: c.faint, size: 22),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Text(
                      '${moments.length} ${moments.length == 1 ? 'moment' : 'moments'} logged',
                      style: TextStyle(color: c.faint, fontSize: 13),
                    ),
                  ),
                  if (raw.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    TrendChart(raw: raw, height: 70),
                    const SizedBox(height: 8),
                    Text(trendDelta(raw),
                        style: TextStyle(color: c.accent, fontSize: 13, fontWeight: FontWeight.w600)),
                  ] else ...[
                    const SizedBox(height: 12),
                    Text('Tap when the urge hits.',
                        style: TextStyle(color: c.muted, fontSize: 14)),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// A dashed-outline "add" card that matches the loop-card shape, sitting at the
/// end of the list — reads as "add another card".
class _AddHabitCard extends StatelessWidget {
  final VoidCallback onTap;
  const _AddHabitCard({required this.onTap});
  @override
  Widget build(BuildContext context) {
    final c = context.c;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: DashedBorder(
          color: c.faint.withValues(alpha: 0.6),
          radius: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Icon(Icons.add, color: c.muted, size: 24),
          ),
        ),
      ),
    );
  }
}
